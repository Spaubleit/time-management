module Web.View.Vacations.Show where
import Web.View.Prelude

data ShowView = ShowView { vacation :: Vacation, user :: User }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <h1>Show Vacation</h1>
        Requester: <b>{get #name user}</b><br/>
        From: <b>{start}</b><br/>
        To: <b>{stop}</b><br/>
        {renderCalendar start [start .. stop]}
        <a href={DeleteVacationAction (get #id vacation)} class="btn btn-primary js-delete">Delete vacation</a>
    |]
        where
            Vacation { start, stop } = vacation
