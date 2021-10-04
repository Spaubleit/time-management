module Web.View.Registrations.Invite where

import Web.View.Prelude

data InviteView = InviteView { url :: Maybe Text }

instance View InviteView where
    html InviteView {..} = [hsx|
        <img src={imageUrl} style="width: 200px; height: 200px; image-rendering: crisp-edges;"/>
    |]
        where
            imageUrl = fromMaybe "" url

