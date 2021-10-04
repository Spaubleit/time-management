module Web.View.Users.Index where
import Web.View.Prelude

data IndexView = IndexView { users :: [User] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <h1>Application users</h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>User</th>
                        <th>Role</th>
                        <th colspan="3">Actions</th>
                    </tr>
                </thead>
                <tbody>{forEach users renderUser}</tbody>
            </table>
        </div>
    |]


renderUser :: User -> Html
renderUser user = [hsx|
    <tr>
        <td>{get #name user}</td>
        <td>{get #userRole user}</td>
        <td><a href={ShowUserAction (get #id user)}>Show</a></td>
        <td><a href={EditUserAction (get #id user)} class="text-muted">Edit</a></td>
        <td><a href={DeleteUserAction (get #id user)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
