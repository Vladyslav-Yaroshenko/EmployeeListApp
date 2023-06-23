//
//  EmloyeeListPresenter.swift
//  EmployeeList
//
//  Created by Vlad on 16.06.2023.
//

import Foundation

/**
 Protocol defining the required methods for managing view
 */
protocol EmployeeListViewProtocol: AnyObject {
    func reloadData()
    func showError()
}

/**
 Protocol defining the required methods for managing presenter
*/
protocol EmployeeListPresenterProtocol: AnyObject {
    init(view: EmployeeListViewProtocol, dataManager: CoreDataManagingProtocol)
    
    var employees: [Departament.RawValue: [Employee]]? { get set }
    var filteredEmployees: [Departament.RawValue: [Employee]]? { get set }
    
    func getEmployees()
    func calculateAverageSalary(employees: [Employee]) -> Float
    func filterEmployees(with searchText: String)
    func getDeparmentCount() -> Int?
    func getEmployeesInDepartment(section: Int) -> [Employee]?
    func configureCellText(indexPath: IndexPath) -> String?
    func getDepartmentName(from section: Int) -> String?
    func removeAll()
    func removeEmployee(id: String, indexPath: IndexPath)
    func getEmployeeID(indexPath: IndexPath) -> String?
    func removeSection(section: Int) 
}


/**
 The EmployeeListPresenter class provides methods for retrieving, filtering, and manipulating the employee list.
 It interacts with the data manager to fetch employee data, performs calculations on the data,
 updates the dictionaries holding the employees, and notifies the view to reload the data.
 It also implements delegate methods to handle events from the AddEmployeePresenter.
 */
class EmployeeListPresenter: EmployeeListPresenterProtocol, AddEmployeePresenterDelegate {
    
    // Variables
    weak var view: EmployeeListViewProtocol?
    let dataManager: CoreDataManagingProtocol!
    var employees: [Departament.RawValue : [Employee]]?
    var filteredEmployees: [Departament.RawValue : [Employee]]?
    var isSearching = false
    weak var delegate: AddEmployeePresenterDelegate?
    
    /// The initializer method for the presenter. It sets up the presenter with a reference to the view and the data manager.
    required init(view: EmployeeListViewProtocol, dataManager: CoreDataManagingProtocol) {
        self.view = view
        self.dataManager = dataManager
        delegate = self
        
    }
    
    /// Retrieves all employees from the data manager and organizes them into departments.
    /// It updates the employees dictionary and notifies the view to reload the data.
    func getEmployees() {
        guard let allEmployees = dataManager.fetchEmployees() else {
            view?.showError()
            return
        }
        
        self.employees = [:]
        
        for department in Departament.allCases {
            self.employees?[department.rawValue] = []
        }
        
        for employee in allEmployees {
            guard let department = employee.department else { return }
            self.employees?[department]?.append(employee)
        }
        employees = employees?.filter({ $0.value.count > 0 })
        self.view?.reloadData()
        
    }
    
    ///Delegate method called when a new employee is added through the AddEmployeePresenter.
    ///It triggers the getEmployees() method to update the employee list.
    func didAddEmployee() {
        getEmployees()
    }
    
    /// Calculates the average salary for a given list of employees.
    func calculateAverageSalary(employees: [Employee]) -> Float {
        let totalSalary = employees.reduce(0) { $0 + ($1.salary) }
        return Float(totalSalary) / Float(employees.count)
    }
    
    /// Filters the employee list based on the provided search text.
    /// It updates the filteredEmployees dictionary and notifies the view to reload the data.
    func filterEmployees(with searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            filteredEmployees = nil
        } else {
            isSearching = true
            filteredEmployees = employees?.compactMapValues { employees in
                employees.filter { employee in
                    let fullName = "\(employee.name ?? "") \(employee.lastName ?? "")"
                    return fullName.range(of: searchText, options: .caseInsensitive) != nil
                }
            }.filter { !$0.value.isEmpty }
        }
        self.view?.reloadData()
    }
    
    /// Retrieves the number of departments in the employee list.
    func getDeparmentCount() -> Int? {
        return isSearching ? filteredEmployees?.count : employees?.count
    }
    
    /// Retrieves the list of employees in a specific department.
    func getEmployeesInDepartment(section: Int) -> [Employee]? {
        var departmentKeys = [Departament.RawValue]()
        
        if isSearching {
            if let filteredEmployees = filteredEmployees {
                departmentKeys = Array(filteredEmployees.keys)
                let department = departmentKeys[section]
                return filteredEmployees[department]
            }
        } else {
            if let employees = employees {
                departmentKeys = Array(employees.keys)
                let department = departmentKeys[section]
                return employees[department]
            }
        }
        return nil
    }
    
    /// Retrieves the text to display in a cell at a given index path.
    func configureCellText(indexPath: IndexPath) -> String? {
        guard let employees = getEmployeesInDepartment(section: indexPath.section) else { return nil }
        let employee = employees[indexPath.row]
        return (employee.name ?? "") + " " + (employee.lastName ?? " ")
    }
    
    /// Retrieves the ID of an employee at a given index path.
    func getEmployeeID(indexPath: IndexPath) -> String? {
        guard let employees = getEmployeesInDepartment(section: indexPath.section) else { return nil }
        let employee = employees[indexPath.row]
        return employee.id
    }
    
    /// Retrieves the name of a department at a given section.
    func getDepartmentName(from section: Int) -> String? {
        var departmentKeys = [Departament.RawValue]()
        
        if isSearching {
            if let filteredEmployees = filteredEmployees {
                departmentKeys = Array(filteredEmployees.keys)
                let department = departmentKeys[section]
                return department
            }
        } else {
            if let employees = employees {
                departmentKeys = Array(employees.keys)
                let department = departmentKeys[section]
                return department
            }
        }
        return nil
    }
    
    // TODO: - Fix
    func removeAll() {
        dataManager.deleteAllEmployees()
    }
    
    /// Removes an employee with the specified ID from the employee list.
    /// It updates the employees and filteredEmployees dictionaries and removes the employee from the data manager.
    func removeEmployee(id: String, indexPath: IndexPath) {
        
        if isSearching {
            guard let department = getDepartmentName(from: indexPath.section) else { return }
            self.filteredEmployees?[department]?.removeAll(where: {$0.id == id})
            self.employees?[department]?.removeAll(where: {$0.id == id})
            
            
        } else {
            guard let department = getDepartmentName(from: indexPath.section) else { return }
            self.employees?[department]?.removeAll(where: {$0.id == id})
            
        }
        dataManager.removeEmployee(id: id)
        
    }
    
    /// Removes a section (department) from the employee list if it is empty.
    /// It updates the employees and filteredEmployees dictionaries.
    func removeSection(section: Int) {
        guard let section = getEmployeesInDepartment(section: section) else { return }
        if section.isEmpty {
            filteredEmployees = filteredEmployees?.filter({ $0.value.count > 0 })
            employees = employees?.filter({ $0.value.count > 0 })
        }
    }

}
