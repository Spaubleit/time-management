module Web.View.Replacements.Confirm where

import Web.View.Prelude

data ConfirmView = ConfirmView { replacement :: Replacement }

instance View ConfirmView where
    html ConfirmView {..} = [hsx||]