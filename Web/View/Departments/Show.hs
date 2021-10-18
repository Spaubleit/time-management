module Web.View.Departments.Show where
import Web.View.Prelude

data ShowView = ShowView { department :: Department }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <h1>Show Department</h1>
        <p>{department}</p>
    |]
