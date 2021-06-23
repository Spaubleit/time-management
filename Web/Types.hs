module Web.Types where

import IHP.Prelude
import IHP.ModelSupport
import Generated.Types
import IHP.LoginSupport.Types

data WebApplication = WebApplication deriving (Eq, Show)


data DashboardController = DashboardAction deriving (Eq, Show, Data)

data StaticController = WelcomeAction deriving (Eq, Show, Data)


instance HasNewSessionUrl User where
    newSessionUrl _ = "/NewSession"

type instance CurrentUserRecord = User

data SessionsController
    = NewSessionAction
    | CreateSessionAction
    | DeleteSessionAction
    deriving (Eq, Show, Data)
    
data UsersController
    = UsersAction
    | NewUserAction
    | ShowUserAction { userId :: !(Id User) }
    | CreateUserAction
    | EditUserAction { userId :: !(Id User) }
    | UpdateUserAction { userId :: !(Id User) }
    | DeleteUserAction { userId :: !(Id User) }
    deriving (Eq, Show, Data)
    
data ShiftsController
    = ShiftsAction
    | NewShiftAction
    | ShowShiftAction { shiftId :: !(Id Shift) }
    | CreateShiftAction
    | EditShiftAction { shiftId :: !(Id Shift) }
    | UpdateShiftAction { shiftId :: !(Id Shift) }
    | DeleteShiftAction { shiftId :: !(Id Shift) }
    deriving (Eq, Show, Data)
