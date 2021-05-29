module Web.Controller.Sessions where

import Web.Controller.Prelude
    ( Controller(action),
      User,
      User'(email, passwordHash, failedLoginAttempts, id),
      SessionsController(..) )
import Web.View.Sessions.New
import qualified IHP.AuthSupport.Controller.Sessions as Sessions

instance Controller SessionsController where
    action NewSessionAction = Sessions.newSessionAction @User
    action CreateSessionAction = Sessions.createSessionAction @User
    action DeleteSessionAction = Sessions.deleteSessionAction @User

instance Sessions.SessionsControllerConfig User
