module Web.View.Users.Edit where
import Web.View.Prelude

data EditView = EditView { user :: User }

instance View EditView where
    html EditView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={UsersAction}>Users</a></li>
                <li class="breadcrumb-item active">Edit User</li>
            </ol>
        </nav>
        <h1>Edit User ({get #name user})</h1>
        {renderForm user}
    |]

roles :: [Role]
roles = [Superadmin, Boss, Worker, Visitor]

instance CanSelect Role where
    type SelectValue Role = Role
    selectValue a = a
    selectLabel a = show a

renderForm :: User -> Html
renderForm user = formFor user [hsx|
    {selectField #userRole roles}
    {submitButton}
|]
