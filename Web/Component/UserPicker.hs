{-# LANGUAGE TemplateHaskell #-}
module Web.Component.UserPicker where

import Web.View.Prelude

import IHP.ViewPrelude
import IHP.ServerSideComponent.Types
import IHP.ServerSideComponent.ControllerFunctions
import IHP.Log as Log

data UserPickerState = UserPickerState
    { users :: [User]
    , selected :: [User]
    }
    deriving (Show)

data UserPickerController
    = SelectAction { userId :: Id User}
    | UnselectAction { userId :: Id User}
    deriving (Eq, Show, Data)

$(deriveSSC ''UserPickerController)

instance Component UserPickerState UserPickerController where
    initialState = UserPickerState { users = [], selected = [] }

    render UserPickerState { users, selected } = [hsx|
        <div class="user-picker">
            {forEach users (\user -> renderUser user $ elem user selected)}
        </div>
    |]

    action state SelectAction { userId } = do
        let user = find (\user -> userId == get #id user) $ get #users state
        Log.debug $ "user " ++ show userId ++ " " ++ show state
        user |> \case
            Nothing -> pure state
            Just user -> state
                |> modify #selected (user :)
                |> pure

    action state UnselectAction { userId } = state 
        |> modify #selected (filter \user -> userId /= get #id user)
        |> pure


renderUser :: User -> Bool -> Html
renderUser User {id, name} selected = [hsx|
    <div 
        class={className}
        onclick={"callServerAction('" ++ action ++ "'," ++ payload ++ ")"}
    >
        {name}  {selected}
    </div>
|]
    where 
        className :: Text
        className = "user " ++ bool "" "selected" selected

        action :: Text
        action = bool "SelectAction" "UnselectAction" selected

        payload :: Text
        payload = "{ userId: '" ++ tshow id ++ "'}"

instance SetField "selected" UserPickerState [User] where setField value state = state { selected = value }