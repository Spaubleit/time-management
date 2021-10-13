module Web.View.Departments.Index where
import Web.View.Prelude

data IndexView = IndexView { departments :: [Department] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item active"><a href={DepartmentsAction}>Departments</a></li>
            </ol>
        </nav>
        <h1>Index <a href={pathTo NewDepartmentAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Department</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach departments renderDepartment}</tbody>
            </table>
        </div>
    |]


renderDepartment :: Department -> Html
renderDepartment department = [hsx|
    <tr>
        <td>{department}</td>
        <td><a href={ShowDepartmentAction (get #id department)}>Show</a></td>
        <td><a href={EditDepartmentAction (get #id department)} class="text-muted">Edit</a></td>
        <td><a href={DeleteDepartmentAction (get #id department)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
