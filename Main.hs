module Main where
import IHP.Prelude

import System.IO (print)

import Config
import qualified IHP.Server
import IHP.RouterSupport
import IHP.FrameworkConfig
import IHP.Job.Types
import Web.FrontController
import Web.Types
import Admin.FrontController
import Admin.Types
import IHP.ScriptSupport
import qualified Application.Script.CreateAdmin as CreateAdmin

instance FrontController RootApplication where
    controllers = [
            mountFrontController WebApplication
            , mountFrontController AdminApplication
        ]

instance Worker RootApplication where
    workers _ = []

main :: IO ()
main = do
    IHP.Server.run config
    runScript config CreateAdmin.run
