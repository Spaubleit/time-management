module Web.Controller.Dashboard where

import Web.Controller.Prelude
import Web.View.Dashboards.Boss
import Web.View.Dashboards.Admin
import Web.View.Dashboards.Visitor
import Web.View.Dashboards.Worker
import Web.View.Dashboards.Welcome

instance Controller DashboardController where
    action DashboardAction = do
        currentUserOrNothing |> \case
            Just user -> get #userRole user |> \case
                Superadmin -> render AdminView 
                Boss -> render BossView 
                Worker -> render WorkerView 
                Visitor -> render VisitorView 
            Nothing -> render WelcomeView