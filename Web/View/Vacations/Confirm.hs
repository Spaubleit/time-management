module Web.View.Vacations.Confirm where

import Web.View.Prelude

data ConfirmView = ConfirmView { vacation :: Vacation }

instance View ConfirmView where
    html ConfirmView {..} = [hsx||]