//
//  EmployeeProfilePresenter.swift
//  EmployeeList
//
//  Created by Vlad on 23.06.2023.
//

import Foundation

/// This protocol defines the interface for a view that displays employee profile information.
protocol EmployeeProfileViewProtocol: AnyObject {
    func setupEmployeeInfo(employee: Employee?)
}

/// This protocol defines the interface for a presenter that handles the logic for the employee profile view.
protocol EmployeeProfilePresenterProtocol: AnyObject {
    init(view: EmployeeProfileViewProtocol, employee: Employee)
    func setEmployee()
}

/**
 Class acts as an intermediary between the view and the employee data.
 It receives the employee object, communicates with the view to set up the employee information, and ensures that the view displays the correct data.
 The presenter helps to separate the concerns of data manipulation and view rendering, promoting a clean and modular architecture.
 */
class EmployeeProfilePresenter: EmployeeProfilePresenterProtocol {
    
    weak var view: EmployeeProfileViewProtocol?
    var employee: Employee?
    
    required init(view: EmployeeProfileViewProtocol, employee: Employee) {
        self.view = view
        self.employee = employee
    }
    
    func setEmployee() {
        self.view?.setupEmployeeInfo(employee: employee)
    }
}
