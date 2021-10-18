module Web.View.Departments.Edit where
import Web.View.Prelude

data EditView = EditView 
    { department :: Department 
    , managers :: [User]
    }

instance View EditView where
    html EditView { .. } = [hsx|
        <h1>Edit Department</h1>
        {renderForm department managers}
    |]

renderForm :: Department -> [User] -> Html
renderForm department managers = formFor department [hsx|
    {(textField #name)}
    {selectField #managerId managers}
    {submitButton}
|]