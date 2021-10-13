module Web.View.Vacations.Index where
import Web.View.Prelude

data IndexView = IndexView { vacations :: [Vacation] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item active"><a href={VacationsAction}>Vacations</a></li>
            </ol>
        </nav>
        <h1>Index <a href={pathTo NewVacationAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Vacation</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach vacations renderVacation}</tbody>
            </table>
        </div>
    |]


renderVacation :: Vacation -> Html
renderVacation vacation = [hsx|
    <tr>
        <td>{vacation}</td>
        <td><a href={ShowVacationAction (get #id vacation)}>Show</a></td>
        <td><a href={EditVacationAction (get #id vacation)} class="text-muted">Edit</a></td>
        <td><a href={DeleteVacationAction (get #id vacation)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
