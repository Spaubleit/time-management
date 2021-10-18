module Web.View.Replacements.Index where

import Web.View.Prelude

data IndexView = IndexView 
    { replacements :: [Include' ["replacableId", "substituteId"] Replacement] 
    }

instance View IndexView where
    html IndexView {..} = [hsx|
        <h1>Replacement requests <a href={NewReplacementAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="replacements">
            {forEach replacements renderReplacement}
        </div>
    |]

renderReplacement :: Include' ["replacableId", "substituteId"] Replacement -> Html
renderReplacement Replacement { id, replacableId, substituteId, date } = [hsx|
    <div class="replacement">
        Requester: <b>{get #name replacableId}</b><br/>
        Substitute: <b>{get #name substituteId}</b><br/>
        Date: <b>{date}</b>
        {renderCalendar date [date]}
        <a href={ShowReplacementAction id}>View</a>
    </div>
|]
