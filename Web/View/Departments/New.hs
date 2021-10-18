module Web.View.Departments.New where
import Web.View.Prelude

data NewView = NewView 
    { department :: Department 
    , managers :: [User]
    }

instance View NewView where
    html NewView { .. } = [hsx|
        <h1>New Department</h1>
        {renderForm department managers}
    |]

renderForm :: Department -> [User] -> Html
renderForm department managers = formFor department [hsx|
    {(textField #name)}
    {selectField #managerId managers}
    {submitButton}
|]
