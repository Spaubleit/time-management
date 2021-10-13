module Web.View.Replacements.Edit where
import Web.View.Prelude

data EditView = EditView { replacement :: Replacement }

instance View EditView where
    html EditView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={ReplacementsAction}>Replacements</a></li>
                <li class="breadcrumb-item active">Edit Replacement</li>
            </ol>
        </nav>
        <h1>Edit Replacement</h1>
        {renderForm replacement}
    |]

renderForm :: Replacement -> Html
renderForm replacement = formFor replacement [hsx|
    {(textField #replacableId)}
    {(textField #substituteId)}
    {submitButton}
|]
