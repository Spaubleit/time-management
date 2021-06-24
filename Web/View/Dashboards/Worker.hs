module Web.View.Dashboards.Worker where

import Web.View.Prelude

data WorkerView = WorkerView

instance View WorkerView where
    html WorkerView = [hsx|<div>worker dashboard</div>|]