module Web.Controller.Shifts where

import Web.Controller.Prelude
import Web.View.Shifts.Index
import Web.View.Shifts.New
import Web.View.Shifts.Edit
import Web.View.Shifts.Show
import IHP.Log as Log

instance Controller ShiftsController where
    action ShiftsAction = do
        shifts <- query @Shift |> fetch
        render IndexView { .. }

    action NewShiftAction = do
        users <- fetchWorkers
        let shift = newRecord
        render NewView { .. }

    action ShowShiftAction { shiftId } = do
        shift <- fetch shiftId
        render ShowView { .. }

    action EditShiftAction { shiftId } = do
        shift <- fetch shiftId
        users <- shift |> get #users |> fetch
        workers <- fetchWorkers
        render EditView { .. }

    action UpdateShiftAction { shiftId } = do
        shift <- fetch shiftId
        users <- shift |> get #users |> fetch
        workers <- fetchWorkers

        let userIds = paramList @(Id User) "users"        

        shift
            |> buildShift
            |> ifValid \case
                Left shift -> render EditView { .. }
                Right shift -> do
                    shift <- shift |> updateRecord
                    mapM_ (updateUser shiftId) userIds
                    setSuccessMessage "Shift updated"
                    redirectTo EditShiftAction { .. }

    action CreateShiftAction = do
        users <- fetchWorkers
        
        Log.info $ show users

        let shift = newRecord @Shift
        shift
            |> buildShift
            |> ifValid \case
                Left shift -> render NewView { .. } 
                Right shift -> do
                    shift <- shift |> createRecord
                    setSuccessMessage "Shift created"
                    redirectTo ShiftsAction

    action DeleteShiftAction { shiftId } = do
        shift <- fetch shiftId
        deleteRecord shift
        setSuccessMessage "Shift deleted"
        redirectTo ShiftsAction

buildShift shift = shift
    |> fill @["name", "start"]
    |> set #duration 5
    |> set #shiftInterval 7


fetchWorkers :: (?modelContext :: ModelContext) => IO [User]
fetchWorkers = query @User 
    |> filterWhere (#userRole, Worker)
    |> fetch

updateUser :: (?modelContext :: ModelContext) => Id Shift -> Id User -> IO ()
updateUser shiftId userId = do
    user <- fetch (userId :: Id User)
    user 
        |> setJust #shiftId shiftId
        |> updateRecord
    pure ()
