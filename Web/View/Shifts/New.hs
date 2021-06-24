{-# LANGUAGE TemplateHaskell #-}
module Web.View.Shifts.New where
import Web.View.Prelude
import IHP.ViewPrelude
import IHP.ServerSideComponent.Types
import IHP.ServerSideComponent.ControllerFunctions

data State = State 
    { selected :: ![User]
    , all :: ![User]
    }

data Actions
    = AddUser !User
    | RemoveUser !User
    deriving (Eq, Show)

instance SetField "selected" State [User] where
    setField value state = state {selected = value}

instance Component State Actions where
    initialState = State { selected = [], all = []}

    render State {selected} = [hsx|<div>{selected}</div>|]

    action state (AddUser user) = state 
        |> modify #selected (user : )
        |> pure

    action state (RemoveUser user) = state
        |> pure

data NewView = NewView { shift :: Shift, users :: [User] }

instance View NewView where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={ShiftsAction}>Shifts</a></li>
                <li class="breadcrumb-item active">New Shift</li>
            </ol>
        </nav>
        <h1>New Shift</h1>
        {renderForm shift users}
    |]

renderForm :: Shift -> [User] -> Html
renderForm shift users = formFor shift [hsx|
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
        <select class="form-control" id="shift_users" multiple name="users">
            {forEach users renderOption}
        </select>
    </div>
|]

renderOption :: User -> Html
renderOption user = [hsx|
    <option value={get #name user}>{get #name user}</option>
|]
