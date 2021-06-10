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
    action DeleteSessionAction = Sessions.deleteSessionAction @User
    action CreateSessionAction = Sessions.createSessionAction @User

instance Sessions.SessionsControllerConfig User
