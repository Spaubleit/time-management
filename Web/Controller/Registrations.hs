module Web.Controller.Registrations where

import Web.Controller.Prelude

import Web.View.Registrations.Invite
import Web.View.Registrations.Register

instance Controller RegistrationsController where
    action RegistrationsActions = do
        registrations <- query @Registration |> fetch
        users <- query @User |> fetch
        render RegisterView {..}

    action NewRegistrationAction = do
        users <- query @User |> fetch
        render RegisterView {..}