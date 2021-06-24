module Web.View.Shifts.Edit where
import Web.View.Prelude

data EditView = EditView 
    { shift :: Shift
    , users :: [User]
    , workers :: [User] 
    }

instance View EditView where
    html EditView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={ShiftsAction}>Shifts</a></li>
                <li class="breadcrumb-item active">Edit Shift</li>
            </ol>
        </nav>
        <h1>Edit Shift</h1>
        {userNames users}
        {renderForm shift workers}
    |]
        where 
            userNames :: [User] -> [Text]
            userNames = map $ get #name

renderForm :: Shift -> [User] -> Html
renderForm shift users = formFor shift [hsx|
    {renderSelect users}
    {submitButton}
|]

renderForm' :: Shift -> [User] -> Html
renderForm' Shift {id} users = [hsx|
    <form action={UpdateShiftAction id} method="DELETE">
        {renderSelect users}
        <button type="submit">Save</button>
    </form>
|]

renderForm'' :: Shift -> [User] -> Html
renderForm'' shift users = formFor shift [hsx|
    {(textField #name)}
    {(dateField #start)}
    {(textField #shiftInterval)}
    {(textField #duration)}
    {renderSelect users}
    {submitButton}
|]

renderSelect :: [User] -> Html
renderSelect users = [hsx|
    <div class="form-group">
        <label for="shift_users">Shift users</label>
        <select class="form-control" id="shift_users" multiple="true" name="users">
            {forEach users renderOption}
        </select>
    </div>
|]

renderOption :: User -> Html
renderOption User {id, name} = [hsx|
    <option value={tshow id}>{name}</option>
|]
