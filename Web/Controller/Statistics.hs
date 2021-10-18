module Web.Controller.Statistics where

import Web.Controller.Prelude

instance Controller StatisticsController where
    action GeneralStatistics = pure ()
    action UserStatistics { userId } = do
        registrations <- query @Registration 
            |> filterWhere (#userId, userId)
            |> fetch
        pure ()
    action DepartmentStatistics { departmentId } = pure ()