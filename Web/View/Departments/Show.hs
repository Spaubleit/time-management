module Web.View.Departments.Show where
import Web.View.Prelude

data ShowView = ShowView { department :: Department }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={DepartmentsAction}>Departments</a></li>
                <li class="breadcrumb-item active">Show Department</li>
            </ol>
        </nav>
        <h1>Show Department</h1>
        <p>{department}</p>
    |]
