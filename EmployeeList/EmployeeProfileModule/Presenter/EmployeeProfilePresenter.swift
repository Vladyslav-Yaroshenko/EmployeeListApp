//
//  EmployeeProfilePresenter.swift
//  EmployeeList
//
//  Created by Vlad on 23.06.2023.
//

import Foundation

protocol EmployeeProfileViewProtocol: AnyObject {
    func setupEmployeeInfo(employee: Employee?)
}

protocol EmployeeProfilePresenterProtocol: AnyObject {
    init(view: EmployeeProfileViewProtocol, employee: Employee)
    func setEmployee()
}

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
