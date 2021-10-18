module Web.View.Replacements.Show where

import Web.View.Prelude

data ShowView = ShowView { replacement :: Replacement }

instance View ShowView where
    html ShowView {..} = [hsx||]