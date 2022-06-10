module Web.View.Vacations.New where
import Web.View.Prelude

data NewView = NewView { vacation :: Vacation }

instance View NewView where
    html NewView { .. } = [hsx|
        <h1>New Vacation</h1>
        {renderForm vacation}
    |]

renderForm :: Vacation -> Html
renderForm vacation = formFor vacation [hsx|
    {hiddenField #state}
    {hiddenField #userId}
    {dateField #start}
    {dateField #stop}
    {submitButton}
|]
