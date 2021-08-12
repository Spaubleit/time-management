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
import Web.Controller.Registrations
import IHP.ServerSideComponent.RouterFunctions
import Web.Component.UserPicker
import Web.Component.Counter

instance FrontController WebApplication where
    controllers = 
        [ startPage DashboardAction 
        , routeComponent @UserPickerState
        , routeComponent @Counter
        , parseRoute @SessionsController 
        , parseRoute @RegistrationsController
        -- Generator Marker
        , parseRoute @ShiftsController
        , parseRoute @UsersController
        ]

instance InitControllerContext WebApplication where
    initContext = do
        setLayout defaultLayout
        initAutoRefresh
        initAuthentication @User