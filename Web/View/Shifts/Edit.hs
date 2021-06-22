module Web.View.Shifts.Edit where
import Web.View.Prelude

data EditView = EditView { shift :: Shift }

instance View EditView where
    html EditView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={ShiftsAction}>Shifts</a></li>
                <li class="breadcrumb-item active">Edit Shift</li>
            </ol>
        </nav>
        <h1>Edit Shift</h1>
        {renderForm shift}
    |]

renderForm :: Shift -> Html
renderForm shift = formFor shift [hsx|
    {(textField #name)}
    {(textField #start)}
    {(textField #shiftInterval)}
    {(textField #duration)}
    {submitButton}
|]
