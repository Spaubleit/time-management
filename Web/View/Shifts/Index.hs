module Web.View.Shifts.Index where
import Web.View.Prelude

data IndexView = IndexView { shifts :: [Shift] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item active"><a href={ShiftsAction}>Shifts</a></li>
            </ol>
        </nav>
        <h1>Index <a href={pathTo NewShiftAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Shift</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach shifts renderShift}</tbody>
            </table>
        </div>
    |]


renderShift :: Shift -> Html
renderShift shift = [hsx|
    <tr>
        <td>{shift}</td>
        <td><a href={ShowShiftAction (get #id shift)}>Show</a></td>
        <td><a href={EditShiftAction (get #id shift)} class="text-muted">Edit</a></td>
        <td><a href={DeleteShiftAction (get #id shift)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
