module Web.View.Departments.Edit where
import Web.View.Prelude

data EditView = EditView { department :: Department }

instance View EditView where
    html EditView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={DepartmentsAction}>Departments</a></li>
                <li class="breadcrumb-item active">Edit Department</li>
            </ol>
        </nav>
        <h1>Edit Department</h1>
        {renderForm department}
    |]

renderForm :: Department -> Html
renderForm department = formFor department [hsx|
    {(textField #name)}
    {(textField #managerId)}
    {submitButton}
|]
