//
//  EmloyeeListPresenter.swift
//  EmployeeList
//
//  Created by Vlad on 16.06.2023.
//

import Foundation


protocol EmployeeListViewProtocol: AnyObject {
    func reloadData()
    func showError()
}


protocol EmployeeListPresenterProtocol: AnyObject {
    init(view: EmployeeListViewProtocol, dataManager: CoreDataManagingProtocol)
    
    var employees: [Departament.RawValue: [Employee]]? { get set }
    var filteredEmployees: [Departament.RawValue: [Employee]]? { get set }
    
    func getEmployees()
    func calculateAverageSalary(employees: [Employee]) -> Float
    func filterEmployees(with searchText: String)
}


class EmployeeListPresenter: EmployeeListPresenterProtocol {
    
    // Variables
    weak var view: EmployeeListViewProtocol?
    let dataManager: CoreDataManagingProtocol!
    var employees: [Departament.RawValue : [Employee]]?
    var filteredEmployees: [Departament.RawValue : [Employee]]?
    var isSearching = false
    
    required init(view: EmployeeListViewProtocol, dataManager: CoreDataManagingProtocol) {
        self.view = view
        self.dataManager = dataManager
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

    
    
}
