module Web.View.Dashboards.Boss where

import Web.View.Prelude

data BossView = BossView

instance View BossView where
    html BossView = [hsx|
        <div>boss view</div>
        <a href={ShiftsAction}>Shifts control</a>
    |]