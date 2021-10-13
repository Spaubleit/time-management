module Web.View.Vacations.Edit where
import Web.View.Prelude

data EditView = EditView { vacation :: Vacation }

instance View EditView where
    html EditView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={VacationsAction}>Vacations</a></li>
                <li class="breadcrumb-item active">Edit Vacation</li>
            </ol>
        </nav>
        <h1>Edit Vacation</h1>
        {renderForm vacation}
    |]

renderForm :: Vacation -> Html
renderForm vacation = formFor vacation [hsx|
    {(textField #userId)}
    {(textField #start)}
    {(textField #stop)}
    {submitButton}
|]
