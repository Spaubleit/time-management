module Web.View.Vacations.Index where
import Web.View.Prelude
import qualified Prelude as P (id)
import qualified Data.Map as M

data IndexView = IndexView { vacations :: [Include "userId" Vacation], state :: ReplacementState }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <h1>Vacations <a href={pathTo NewVacationAction} class="btn btn-primary ml-4">+ New</a></h1>
        <ul class="nav nav-tabs">
            <li class="nav-item">
                <a class={confirmedClass} href={(pathTo VacationsAction) <> "?state=" <> tshow ReplacementApproved}>Confirmed</a>
            </li>
            <li class="nav-item">
                <a class={rejectedClass} href={(pathTo VacationsAction) <> "?state=" <> tshow ReplacementRejected}>Rejected</a>
            </li>
            <li class="nav-item">
                <a class={requestedClass} href={(pathTo VacationsAction) <> "?state=" <> tshow ReplacementRequest}>Requested</a>
            </li>
        </ul>
        <div class="vacations">
            {forEach vacations renderVacation}
        </div>
    |]
        where
            confirmedClass = clsx $ M.fromList [("nav-link", True), ("active", state == ReplacementApproved)]
            requestedClass = clsx $ M.fromList [("nav-link", True), ("active", state == ReplacementRequest)]
            rejectedClass = clsx $ M.fromList [("nav-link", True), ("active", state == ReplacementRejected)]


renderVacation :: Include "userId" Vacation -> Html
renderVacation Vacation { id, userId, start, stop } = [hsx|
    <div class="vacation">
        Requester: <b>{get #name userId}</b><br/>
        From: <b>{start}</b><br/>
        To: <b>{stop}</b><br/>
        {renderCalendar start [start .. stop]}
        <a href={ShowVacationAction id}>View</a>
    </div>
|]

