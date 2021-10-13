module Web.Controller.Departments where

import Web.Controller.Prelude
import Web.View.Departments.Index
import Web.View.Departments.New
import Web.View.Departments.Edit
import Web.View.Departments.Show

instance Controller DepartmentsController where
    action DepartmentsAction = do
        departments <- query @Department |> fetch
        render IndexView { .. }

    action NewDepartmentAction = do
        let department = newRecord
        render NewView { .. }

    action ShowDepartmentAction { departmentId } = do
        department <- fetch departmentId
        render ShowView { .. }

    action EditDepartmentAction { departmentId } = do
        department <- fetch departmentId
        render EditView { .. }

    action UpdateDepartmentAction { departmentId } = do
        department <- fetch departmentId
        department
            |> buildDepartment
            |> ifValid \case
                Left department -> render EditView { .. }
                Right department -> do
                    department <- department |> updateRecord
                    setSuccessMessage "Department updated"
                    redirectTo EditDepartmentAction { .. }

    action CreateDepartmentAction = do
        let department = newRecord @Department
        department
            |> buildDepartment
            |> ifValid \case
                Left department -> render NewView { .. } 
                Right department -> do
                    department <- department |> createRecord
                    setSuccessMessage "Department created"
                    redirectTo DepartmentsAction

    action DeleteDepartmentAction { departmentId } = do
        department <- fetch departmentId
        deleteRecord department
        setSuccessMessage "Department deleted"
        redirectTo DepartmentsAction

buildDepartment department = department
    |> fill @["name","managerId"]
