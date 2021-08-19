module Web.View.Registrations.Register where

import Web.View.Prelude
import Web.Component.UserPicker
import Web.Component.Counter
import IHP.ServerSideComponent.ViewFunctions
import Data.ByteString.Lazy.Internal

data RegisterView = RegisterView { users :: [User], url :: Maybe Text }

instance View RegisterView where
    html RegisterView {..} = [hsx|
        <div>{counter}</div>
        <div>{picker}</div>
        <img src={imageUrl}/>
    |]
        where
            imageUrl = fromMaybe "" url
            counter = componentFromState @Counter (Counter {value = 10})
            picker = componentFromState @UserPickerState (UserPickerState 
                { users = users, selected = [] })