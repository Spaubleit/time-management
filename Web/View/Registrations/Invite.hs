module Web.View.Registrations.Invite where

import Web.View.Prelude

data InviteView = InviteView { url :: Maybe Text }

instance View InviteView where
    html InviteView {..} = [hsx|
        <img src={imageUrl}/>
    |]
        where
            imageUrl = fromMaybe "" url

