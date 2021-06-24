module Web.View.Dashboards.Admin where
import Web.View.Prelude

data AdminView = AdminView

instance View AdminView where
    html AdminView = [hsx|<div>admin dashboard</div>|]