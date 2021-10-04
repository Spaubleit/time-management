{-# LANGUAGE PatternSynonyms #-}

module Web.View.Shifts.Show where
import Web.View.Prelude
import Data.Time.Calendar
import Data.Time.Calendar.MonthDay
import Data.Time.Calendar.Compat
import qualified Data.Map as M
import qualified Prelude as P

data ShowView = ShowView { shift :: Shift, now :: UTCTime  }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <h1>Show Shift</h1>
        <div>{get #name shift}</div>
        {renderCalendar now shift}
    |]

data Interval = Interval
    { start :: Day
    , duration :: Int
    , interval :: Int }

generateIntervals :: Int -> Interval -> [Day]
generateIntervals count interval = go count interval
    where
        generate :: Int -> Day -> [Day]
        generate duration start = map (`addDays` start) [0 .. (toInteger duration-1)]

        go :: Int -> Interval -> [Day]
        go 0 _ = []
        go count params@Interval { start, duration, interval } =
            generate duration start ++ go (count -1) params { start = addDays (toInteger interval) start}

clsx :: Map Text Bool -> Text
clsx = unwords . M.keys . M.filter P.id

renderCalendar :: UTCTime -> Shift -> Html
renderCalendar now shift = [hsx|
    <div class="calendar">
        {forEach prepend renderEmpty}
        {forEach days renderDay}
    </div>
|]
    where
        today = get #utctDay now
        YearMonthDay year monthOfYear day = today
        start = firstDayOfWeekOnAfter Monday today
        length = monthLength (isLeapYear year) monthOfYear

        intervals = generateIntervals 1000 Interval
            { start = get #start shift
            , duration = get #duration shift
            , interval = get #shiftInterval shift }

        days = map (YearMonthDay year monthOfYear) [1..length]
        prepend = head days
            |> fmap (subtract 1 . fromEnum . dayOfWeek)
            |> fromMaybe 0
            |> (`replicate` ())

        renderEmpty :: () -> Html
        renderEmpty _ = [hsx|<div class="day"></div>|]

        renderDay :: Day -> Html
        renderDay day@(YearMonthDay _ _ dayOfMonth) =
            let className = clsx $ M.fromList 
                    [ ("day", True)
                    , ("marked", day `elem` intervals)
                    , ("current", today == day)
                    ]
            in [hsx|<div class={className}>{dayOfMonth}</div>|]

