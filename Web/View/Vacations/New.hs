module Web.View.Vacations.New where
import Web.View.Prelude

data NewView = NewView { vacation :: Vacation }

instance View NewView where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={VacationsAction}>Vacations</a></li>
                <li class="breadcrumb-item active">New Vacation</li>
            </ol>
        </nav>
        <h1>New Vacation</h1>
        {renderForm vacation}
    |]

renderForm :: Vacation -> Html
renderForm vacation = formFor vacation [hsx|
    {(textField #userId)}
    {(textField #start)}
    {(textField #stop)}
    {submitButton}
|]
