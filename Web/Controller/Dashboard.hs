module Web.Controller.Dashboard where

import Web.Controller.Prelude
import Web.View.Dashboards.Boss
import Web.View.Dashboards.Admin
import Web.View.Dashboards.Visitor
import Web.View.Dashboards.Worker
import Web.View.Dashboards.Welcome
import Data.Text.Encoding

instance Controller DashboardController where
    action DashboardAction = do
        now <- getCurrentTime 
        case currentUserOrNothing of
            Nothing -> render WelcomeView
            Just user@User { id, userRole, shiftId, departmentId } -> case userRole of
                Superadmin -> render AdminView 
                Boss -> do
                    registrations <- query @Registration 
                        |> filterWhere (#day, get #utctDay now)
                        |> fetch >>= collectionFetchRelated #userId
                    render BossView { .. }
                Visitor -> render VisitorView 
                Worker -> do 
                    -- test <- user >>= fetchRelated #shiftId
                    -- registration <- query @Registration 
                    --     |> filterWhereSql (#shiftId, "= 0")
                    --     -- |> filterWhereSql (#shiftId, encodeUtf8 $ " = " <> tshow shiftId)
                    --     |> filterWhere (#userId, id)
                    --     |> fetchOneOrNothing
                    render WorkerView { registration = Nothing }