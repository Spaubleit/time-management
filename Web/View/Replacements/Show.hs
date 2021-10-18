module Web.View.Replacements.Show where

import Web.View.Prelude

data ShowView = ShowView { replacement :: Replacement, replacable :: User, substitute :: User }

instance View ShowView where
    html ShowView {..} = [hsx|
        <h1>Replacement view</h1>
        <div>Requester: {get #name replacable}</div>
        <div>Substitute: {get #name substitute}</div>
        <div>Date: {get #date replacement}</div>
        <a href={DeleteReplacementAction (get #id replacement)} class="js-delete">Delete replacement request</a>
    |]