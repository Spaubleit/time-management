module Web.View.Shifts.Index where
import Web.View.Prelude

data IndexView = IndexView { shifts :: [Shift] }

instance View IndexView where
    html IndexView { .. } = [hsx|
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
renderShift Shift {id, name} = [hsx|
    <tr>
        <td>{name}</td>
        <td><a href={ShowShiftAction id}>Show</a></td>
        <td><a href={EditShiftAction id} class="text-muted">Edit</a></td>
        <td><a href={DeleteShiftAction id} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
