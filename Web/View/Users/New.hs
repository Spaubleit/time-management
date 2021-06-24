module Web.View.Users.New where
import Web.View.Prelude

data NewView = NewView { user :: User }

instance View NewView where
    html NewView { .. } = [hsx|
        <h1>Log in</h1>
        {renderForm user}
    |]

renderForm :: User -> Html
renderForm user = formFor user [hsx|
    {(textField #name)}
    {(textField #email)}
    {(passwordField #passwordHash) {fieldLabel = "Password"}}
    {submitButton}
|]
