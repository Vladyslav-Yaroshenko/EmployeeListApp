//
//  EmloyeeListPresenter.swift
//  EmployeeList
//
//  Created by Vlad on 16.06.2023.
//

import Foundation

///Protocol defining the required methods for managing view
protocol EmployeeListViewProtocol: AnyObject {
    func reloadData()
    func showError()
}

///Protocol defining the required methods for managing presenter
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
}


// PRESENTER
class EmployeeListPresenter: EmployeeListPresenterProtocol, AddEmployeePresenterDelegate {
    
    // Variables
    weak var view: EmployeeListViewProtocol?
    let dataManager: CoreDataManagingProtocol!
    var employees: [Departament.RawValue : [Employee]]?
    var filteredEmployees: [Departament.RawValue : [Employee]]?
    var isSearching = false
    weak var delegate: AddEmployeePresenterDelegate?
    
    required init(view: EmployeeListViewProtocol, dataManager: CoreDataManagingProtocol) {
        self.view = view
        self.dataManager = dataManager
        delegate = self
        
    }
    
    // Get all employees from core data
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
    
    func didAddEmployee() {
        getEmployees()
    }
    
    func calculateAverageSalary(employees: [Employee]) -> Float {
        let totalSalary = employees.reduce(0) { $0 + ($1.salary) }
        return Float(totalSalary) / Float(employees.count)
    }
    
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
    }
    
    func getDeparmentCount() -> Int? {
        return isSearching ? filteredEmployees?.count : employees?.count
    }
    
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
    
    func configureCellText(indexPath: IndexPath) -> String? {
        guard let employees = getEmployeesInDepartment(section: indexPath.section) else { return nil }
        let employee = employees[indexPath.row]
        return (employee.name ?? "") + " " + (employee.lastName ?? " ")
    }
    
    
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
}
