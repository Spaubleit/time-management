#!/usr/bin/env run-script
{-# LANGUAGE DeriveGeneric, DeriveAnyClass #-}
module Application.Script.CreateAdmin where

import Application.Script.Prelude
import System.IO (print)
import Data.Text.IO (getLine)
import Dhall

data Config = Config 
    { adminEmail :: Text 
    , adminPassword :: Text 
    } deriving (Generic, Show)

instance FromDhall Config

run :: Script
run = do
    Config {adminEmail, adminPassword} <- input auto "./config.dhall"
    passwordHash <- hashPassword adminPassword
    let admin = newRecord @User 
    admin 
        |> set #name "admin"
        |> set #email adminEmail
        |> set #passwordHash passwordHash
        |> set #userRole Superadmin 
        |> createRecord
    pure ()
