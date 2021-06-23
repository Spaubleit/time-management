module Web.Controller.Dashboard where

import Web.Controller.Prelude
import Web.View.Dashboards.Boss

instance Controller DashboardController where
    action DashboardAction = render BossView 