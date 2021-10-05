module Web.View.Dashboards.Boss where

import Web.View.Prelude

data BossView = BossView

instance View BossView where
    html BossView = [hsx|
        <h1>Boss Dashboard</h1>
        <div>
            <a href={ShiftsAction}>Shifts control</a>
        </div>
        <div>
            <a href={NewRegistrationAction}>Registrations control</a>
        </div>
    |]