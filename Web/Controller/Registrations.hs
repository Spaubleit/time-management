module Web.Controller.Registrations where

import Web.Controller.Prelude

import Web.View.Registrations.Invite
import Web.View.Registrations.Register
import qualified Codec.QRCode as QR
import Codec.QRCode.JuicyPixels
import Data.Text.Lazy

instance Controller RegistrationsController where
    action RegistrationsActions = do
        registrations <- query @Registration |> fetch
        let url = Nothing
        users <- query @User |> fetch
        render RegisterView {..}

    action NewRegistrationAction = do
        let image = QR.encode (QR.defaultQRCodeOptions QR.M) QR.Iso8859_1OrUtf8WithoutECI ("Hello World" :: String)
        let url = fmap (toStrict . toPngDataUrlT 0 1) image
        users <- query @User |> fetch
        render RegisterView {..}