module Web.View.Dashboards.Admin where
import Web.View.Prelude

data AdminView = AdminView

instance View AdminView where
    html AdminView = [hsx|
        <div>admin dashboard</div>
        <a href={UsersAction}>Permissions control</a><br/>
        <a href={DepartmentsAction}>Departments control</a>
    |]