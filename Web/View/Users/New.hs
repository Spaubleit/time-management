module Web.View.Users.New where
import Web.View.Prelude

data NewView = NewView { user :: User }

instance View NewView where
    html NewView { .. } = [hsx|
        <h1>{title}</h1>
        {renderForm user}
    |]
        where
            title :: Text = if isNew user 
                then "Register"
                else "Log In"

renderForm :: User -> Html
renderForm user = formFor user [hsx|
    {(textField #name)}
    {(textField #email)}
    {(passwordField #passwordHash) {fieldLabel = "Password"}}
    {submitButton}
|]
