module Web.View.Registrations.Register where

import Web.View.Prelude
import Web.Component.UserPicker
import Web.Component.Counter
import IHP.ServerSideComponent.ViewFunctions
import Data.ByteString.Lazy.Internal

data RegisterView = RegisterView { shift :: Maybe Shift}

instance View RegisterView where
    html RegisterView {..} = [hsx|
        <h2>{message}</h2>
        {form}
    |]
        where
            message :: Text = case shift of
                Nothing -> "There is no shift for you"
                Just shift -> "Are you sure you want to register to '" <> get #name shift <> "'?"
            form = case shift of
                Nothing -> [hsx||]
                Just Shift { id } -> [hsx|
                        <form method="POST" action={pathTo (CreateRegistrationAction id)}>
                            <button class="btn btn-primary">Register</button>
                        </form>
                    |]