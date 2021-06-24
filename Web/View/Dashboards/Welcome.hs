module Web.View.Dashboards.Welcome where

import Web.View.Prelude

data WelcomeView = WelcomeView

instance View WelcomeView where
    html WelcomeView = [hsx|<div>We are welcome you on our website.</div>|]