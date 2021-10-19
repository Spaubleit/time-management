module Web.View.Dashboards.Boss where

import Web.View.Prelude

data BossView = BossView { registrations :: [Include "userId" Registration]}

instance View BossView where
    html BossView { registrations } = [hsx|
        <h1>Boss Dashboard</h1>
        <div>
            <a href={ShiftsAction}>Shifts control</a>
        </div>
        <div>
            <a href={NewRegistrationAction}>Registrations control</a>
        </div>
        <div>
            <a href="">Vacations control</a>
        </div>
        <div>
            <h2>Active registrations</h2>
            {forEach registrations renderRegistration}
        </div>
    |]

renderRegistration :: Include "userId" Registration -> Html
renderRegistration registration = [hsx|
    {registration}
|]