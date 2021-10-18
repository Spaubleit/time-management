module Web.View.Replacements.Index where

import Web.View.Prelude

data IndexView = IndexView { replacements :: [Replacement] }

instance View IndexView where
    html IndexView {..} = [hsx||]