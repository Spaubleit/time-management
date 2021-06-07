module Web.Controller.Sessions where

import Web.Controller.Prelude
import Web.View.Sessions.New
import qualified IHP.AuthSupport.Controller.Sessions as Sessions
import Data.Either
import IHP.AuthSupport.View.Sessions.New
import qualified IHP.Log as Log

instance Controller SessionsController where
    action NewSessionAction = do 
        Log.debug ("@@@@@NewMessageAction" :: String )
        Sessions.newSessionAction @User
    action DeleteSessionAction = Sessions.deleteSessionAction @User
    action CreateSessionAction = do
        Log.info ("@@@@@CreateSessionAction" :: String)
        let user = newRecord @User
        user
            |> fill @["email", "name", "passwordHash"]
            |> validateField #email isEmail
            |> validateField #passwordHash nonEmpty
            |> ifValid \case
                Left user -> render NewView {user = user}
                Right user -> do
                    hashed <- hashPassword (get #passwordHash user)
                    user <- user
                        |> set #passwordHash hashed
                        |> createRecord
                    setSuccessMessage "You have registered successfully"

instance Sessions.SessionsControllerConfig User
