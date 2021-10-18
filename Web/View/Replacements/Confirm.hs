module Web.View.Replacements.Confirm where

import Web.View.Prelude

data ConfirmView = ConfirmView { replacement :: Replacement, replacable :: User }

instance View ConfirmView where
    html ConfirmView {..} = formFor replacement [hsx|
        <h2>Replacement confirmation</h2>
        {hiddenField #state}
        {get #name replacable} ask you to replace them on {get #date replacement}. Are you want to confirm thier request?
        {submitButton { label = "Confirm" }}
    |]