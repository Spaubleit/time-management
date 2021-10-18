module Web.Controller.Replacements where

import Web.Controller.Prelude
import Web.View.Replacements.Index
import Web.View.Replacements.New
import Web.View.Replacements.Show
import Web.View.Replacements.Confirm

instance Controller ReplacementsController where
    action ReplacementsAction = do
        replacements <- query @Replacement 
            |> fetch
            >>= collectionFetchRelated #replacableId
            >>= collectionFetchRelated #substituteId
        render IndexView { .. }

    action NewReplacementAction = do
        let replacement = newRecord 
                |> set #replacableId currentUserId
                |> set #state ReplacementRequest
        users <- fetchSubstituteUsers currentUser
        render NewView { .. }

    action ShowReplacementAction { replacementId } = do
        replacement <- fetch replacementId
        let Replacement {replacableId, substituteId} = replacement
        replacable <- fetch replacableId
        substitute <- fetch substituteId
        if currentUserId == replacableId
            then render ShowView {..}
            else if currentUserId == substituteId
                then render ConfirmView {..}
                else renderNotFound

    action UpdateReplacementAction { replacementId } = do
        replacement <- fetch replacementId
        replacable <- fetch (get #replacableId replacement)
        replacement
            |> buildReplacement
            |> set #state ReplacementApproved
            |> ifValid \case
                Left replacement -> render ConfirmView { .. }
                Right replacement -> do
                    replacement <- replacement |> updateRecord
                    setSuccessMessage "Replacement updated"
                    redirectTo ReplacementsAction

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
                    redirectTo ReplacementsAction

    action DeleteReplacementAction { replacementId } = do
        replacement <- fetch replacementId
        deleteRecord replacement
        setSuccessMessage "Replacement deleted"
        redirectTo ReplacementsAction

buildReplacement replacement = replacement
    |> fill @["replacableId", "substituteId", "state"]

fetchSubstituteUsers :: (?modelContext :: ModelContext) => User -> IO [User]
fetchSubstituteUsers User { id, departmentId } = query @User 
    |> filterWhere (#departmentId, departmentId)
    |> filterWhereNot (#id, id)
    |> fetch