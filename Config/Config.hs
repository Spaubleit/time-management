module Config where

import IHP.Prelude
import IHP.Environment
import IHP.FrameworkConfig
import IHP.Log.Types
import qualified IHP.Log as Log

config :: ConfigBuilder
config = do
    logger <- liftIO $ newLogger def
        { level = Debug
        , formatter = withTimeFormatter
        }
    option logger
    option Development
    option (AppHostname "localhost")