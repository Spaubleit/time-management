{-# LANGUAGE PatternSynonyms #-}

module Web.View.Shifts.Show where
import Web.View.Prelude

data ShowView = ShowView { shift :: Shift, today :: Day }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <h1>Show Shift</h1>
        <div>{get #name shift}</div>
        {renderCalendar today intervals}
        <a href={NewRegistrationAction}>Create registration</a>
    |]
        where 
            intervals = intervalsFromShift shift

intervalsFromShift :: Shift -> [Day]
intervalsFromShift Shift { start, duration, shiftInterval} = generateIntervals 1000 Interval 
    { start = start
    , duration = duration
    , interval = shiftInterval
    }


