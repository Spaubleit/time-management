module Web.Controller.Replacements where

import Web.Controller.Prelude
import Web.View.Replacements.Index
import Web.View.Replacements.New
import Web.View.Replacements.Edit
import Web.View.Replacements.Show

instance Controller ReplacementsController where
    action ReplacementsAction = do
        replacements <- query @Replacement |> fetch
        render IndexView { .. }

    action NewReplacementAction = do
        let replacement = newRecord
        render NewView { .. }

    action ShowReplacementAction { replacementId } = do
        replacement <- fetch replacementId
        render ShowView { .. }

    action EditReplacementAction { replacementId } = do
        replacement <- fetch replacementId
        render EditView { .. }

    action UpdateReplacementAction { replacementId } = do
        replacement <- fetch replacementId
        replacement
            |> buildReplacement
            |> ifValid \case
                Left replacement -> render EditView { .. }
                Right replacement -> do
                    replacement <- replacement |> updateRecord
                    setSuccessMessage "Replacement updated"
                    redirectTo EditReplacementAction { .. }

    action CreateReplacementAction = do
        let replacement = newRecord @Replacement
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
    |> fill @["replacableId","substituteId"]
