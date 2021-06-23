module Web.FrontController where

import IHP.RouterPrelude
import Web.Controller.Prelude
import Web.View.Layout (defaultLayout)

-- Controller Imports
import Web.Controller.Shifts
import Web.Controller.Users
import Web.Controller.Static
import IHP.LoginSupport.Middleware
import Web.Controller.Sessions
import Web.Controller.Dashboard

instance FrontController WebApplication where
    controllers = 
        [ startPage DashboardAction 
        , parseRoute @SessionsController 
        -- Generator Marker
        , parseRoute @ShiftsController
        , parseRoute @UsersController
        ]

instance InitControllerContext WebApplication where
    initContext = do
        setLayout defaultLayout
        initAutoRefresh
        initAuthentication @User