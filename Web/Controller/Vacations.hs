module Web.Controller.Vacations where

import Web.Controller.Prelude
import Web.View.Vacations.Index
import Web.View.Vacations.New
import Web.View.Vacations.Edit
import Web.View.Vacations.Show

instance Controller VacationsController where
    action VacationsAction = do
        vacations <- query @Vacation |> fetch
        render IndexView { .. }

    action NewVacationAction = do
        let vacation = newRecord
        render NewView { .. }

    action ShowVacationAction { vacationId } = do
        vacation <- fetch vacationId
        render ShowView { .. }

    action EditVacationAction { vacationId } = do
        vacation <- fetch vacationId
        render EditView { .. }

    action UpdateVacationAction { vacationId } = do
        vacation <- fetch vacationId
        vacation
            |> buildVacation
            |> ifValid \case
                Left vacation -> render EditView { .. }
                Right vacation -> do
                    vacation <- vacation |> updateRecord
                    setSuccessMessage "Vacation updated"
                    redirectTo EditVacationAction { .. }

    action CreateVacationAction = do
        let vacation = newRecord @Vacation
        vacation
            |> buildVacation
            |> ifValid \case
                Left vacation -> render NewView { .. } 
                Right vacation -> do
                    vacation <- vacation |> createRecord
                    setSuccessMessage "Vacation created"
                    redirectTo VacationsAction

    action DeleteVacationAction { vacationId } = do
        vacation <- fetch vacationId
        deleteRecord vacation
        setSuccessMessage "Vacation deleted"
        redirectTo VacationsAction

buildVacation vacation = vacation
    |> fill @["userId","start","stop"]
