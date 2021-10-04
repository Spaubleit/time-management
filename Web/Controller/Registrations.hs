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
import Text.Read (readMaybe, read)
import qualified Data.Text as T (unpack)

createQRCode :: Text -> Maybe QR.QRImage
createQRCode = QR.encode (QR.defaultQRCodeOptions QR.M) QR.Iso8859_1OrUtf8WithoutECI

instance Controller RegistrationsController where
    action RegistrationsActions = do
        registrations <- query @Registration |> fetch
        let url = Nothing
        users <- query @User |> fetch
        pure ()

    action NewRegistrationAction = do
        time <- getCurrentTime
        let key = time |> utctDay |> show |> encodeBase64
        let baseUrl = ?context |> getFrameworkConfig |> get #baseUrl
        let url = (baseUrl <> pathTo AddRegistrationAction <> "?key=" <> key) |> createQRCode
                |> fmap (toStrict . toPngDataUrlT 0 1)
        Log.debug $ "Key" <> key
        Log.debug $ "Before encode " <> show (time |> utctDay)
        Log.debug $ "Decoded" <> show (decodeBase64 key)
        users <- query @User |> fetch
        render InviteView {..}

    action AddRegistrationAction = do
        let key = param @Text "key"
        let day = key |> decodeBase64 |> fmap (read @Day . T.unpack)
        
        let day = do
            decoded <- decodeBase64 key
            let day = read @Day . T.unpack $ decoded
            pure UTCTime 
                    { utctDay = day
                    , utctDayTime = 0
                    }

        let user = currentUser
        let shiftId = user |> get #shiftId

        shift <- fetchOneOrNothing shiftId

        day |> \case
            Left error -> pure ()
            Right day -> render RegisterView {..}

        