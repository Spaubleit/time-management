module Web.Routes where
import IHP.RouterPrelude
import Generated.Types
import Web.Types

instance AutoRoute DashboardController 
instance AutoRoute RegistrationsController

-- Generator Marker
instance AutoRoute StaticController

instance AutoRoute SessionsController
instance AutoRoute UsersController


instance AutoRoute ShiftsController


instance AutoRoute DepartmentsController


instance AutoRoute VacationsController


instance AutoRoute ReplacementsController

