module Web.View.Replacements.New where
import Web.View.Prelude

data NewView = NewView { replacement :: Replacement }

instance View NewView where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={ReplacementsAction}>Replacements</a></li>
                <li class="breadcrumb-item active">New Replacement</li>
            </ol>
        </nav>
        <h1>New Replacement</h1>
        {renderForm replacement}
    |]

renderForm :: Replacement -> Html
renderForm replacement = formFor replacement [hsx|
    {(textField #replacableId)}
    {(textField #substituteId)}
    {submitButton}
|]
