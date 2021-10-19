module Web.View.Dashboards.Worker where

import Web.View.Prelude

data WorkerView = WorkerView { registration :: Maybe Registration }

instance View WorkerView where
    html WorkerView {..} = [hsx|
        <h1>Worker Dashboard</h1>
        <a href={ReplacementsAction}>Replacements</a><br/>
        <a href={VacationsAction}>Vacations</a><br/>
    |]