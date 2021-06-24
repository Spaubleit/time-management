module Web.Controller.Sessions where

import Web.Controller.Prelude
import Web.View.Sessions.New
import qualified IHP.AuthSupport.Controller.Sessions as Sessions
import Data.Either
import IHP.AuthSupport.View.Sessions.New
import qualified IHP.Log as Log

instance Controller SessionsController where
    action NewSessionAction = do 
        Sessions.newSessionAction @User
    action DeleteSessionAction = do
        Sessions.deleteSessionAction @User
        redirectToPath "/"
    action CreateSessionAction = Sessions.createSessionAction @User

instance Sessions.SessionsControllerConfig User
