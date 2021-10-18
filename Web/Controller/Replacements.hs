module Web.Controller.Replacements where

import Web.Controller.Prelude
import Web.View.Replacements.Index
import Web.View.Replacements.New
import Web.View.Replacements.Show
import Web.View.Replacements.Confirm

instance Controller ReplacementsController where
    action ReplacementsAction = do
        replacements <- query @Replacement |> fetch
        render IndexView { .. }

    action NewReplacementAction = do
        let replacement = newRecord 
                |> set #replacableId currentUserId
        users <- fetchSubstituteUsers currentUser
        render NewView { .. }

    action ShowReplacementAction { replacementId } = do
        replacement <- fetch replacementId
        render ShowView { .. }

    action ConfirmReplacementAction { replacementId } = do
        replacement <- fetch replacementId
        render ConfirmView { .. }

    action UpdateReplacementAction { replacementId } = do
        replacement <- fetch replacementId
        replacement
            |> buildReplacement
            |> ifValid \case
                Left replacement -> render ConfirmView { .. }
                Right replacement -> do
                    replacement <- replacement |> updateRecord
                    setSuccessMessage "Replacement updated"
                    redirectTo ConfirmReplacementAction { .. }

    action CreateReplacementAction = do
        let replacement = newRecord @Replacement
        users <- fetchSubstituteUsers currentUser
        replacement
            |> buildReplacement
            |> ifValid \case
                Left replacement -> render NewView { .. } 
                Right replacement -> do
                    replacement <- replacement |> createRecord
                    setSuccessMessage "Replacement created"
                    redirectToPath ""

    action DeleteReplacementAction { replacementId } = do
        replacement <- fetch replacementId
        deleteRecord replacement
        setSuccessMessage "Replacement deleted"
        redirectToPath ""

buildReplacement replacement = replacement
    |> fill @["replacableId","substituteId"]

fetchSubstituteUsers :: (?modelContext :: ModelContext) => User -> IO [User]
fetchSubstituteUsers User { id, departmentId } = query @User 
    |> filterWhere (#departmentId, departmentId)
    |> filterWhereNot (#id, id)
    |> fetch