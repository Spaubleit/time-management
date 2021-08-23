module Web.Controller.Registrations where

import Web.Controller.Prelude

import Web.View.Registrations.Invite
import Web.View.Registrations.Register
import qualified Codec.QRCode as QR
import Codec.QRCode.JuicyPixels
import Data.Text.Lazy (toStrict)
import Data.Time.Clock
import qualified IHP.Log as Log
import Data.Text.Encoding.Base64 (encodeBase64, decodeBase64)

createQRCode :: Text -> Maybe QR.QRImage
createQRCode = QR.encode (QR.defaultQRCodeOptions QR.M) QR.Iso8859_1OrUtf8WithoutECI

instance Controller RegistrationsController where
    action RegistrationsActions = do
        registrations <- query @Registration |> fetch
        let url = Nothing
        users <- query @User |> fetch
        render RegisterView {..}

    action NewRegistrationAction = do
        time <- getCurrentTime
        let key = time |> utctDay |> show |> encodeBase64
        let baseUrl = ?context |> getFrameworkConfig |> get #baseUrl
        let url = (baseUrl <> pathTo AddRegistrationAction <> "?key=" <> key) |> createQRCode
                |> fmap (toStrict . toPngDataUrlT 0 1)
        users <- query @User |> fetch
        render InviteView {..}

    action AddRegistrationAction = do
        let key = param @Text "key"
        let date = decodeBase64 key
        pure ()