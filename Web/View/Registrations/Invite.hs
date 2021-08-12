module Web.View.Registrations.Invite where

import Web.View.Prelude

data InviteView = InviteView { registration :: Registration }

instance View InviteView where
    html InviteView {..} = [hsx|qr code here|]

