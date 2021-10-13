module Web.View.Departments.New where
import Web.View.Prelude

data NewView = NewView { department :: Department }

instance View NewView where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={DepartmentsAction}>Departments</a></li>
                <li class="breadcrumb-item active">New Department</li>
            </ol>
        </nav>
        <h1>New Department</h1>
        {renderForm department}
    |]

renderForm :: Department -> Html
renderForm department = formFor department [hsx|
    {(textField #name)}
    {(textField #managerId)}
    {submitButton}
|]
