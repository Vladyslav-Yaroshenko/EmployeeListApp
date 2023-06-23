//
//  AddEmployeePresenter.swift
//  EmployeeList
//
//  Created by Vlad on 17.06.2023.
//

import Foundation

/**
 This protocol defines the required methods that the view must conform to, including showing an error.
 */
protocol AddEmployeeViewProtocol: AnyObject {
    func showError()
}

/**
 This protocol defines the delegate methods that the AddEmployeePresenter conforms to.
 It includes the didAddEmployee() method, which is called when an employee is successfully added, allowing the presenter to notify the delegate.
 */
protocol AddEmployeePresenterDelegate: AnyObject {
    func didAddEmployee()
}

/**
 This protocol defines the required methods that the presenter must conform to, including initializing the presenter with a view and a data manager, and adding an employee with the specified details.
 */
protocol AddEmployeePresenterProtocol: AnyObject {
    init(view: AddEmployeeViewProtocol, dataManager: CoreDataManagingProtocol)
    func addEmployee(name: String,
                     lastName: String,
                     salary: Float,
                     gender: String,
                     birthday: Date,
                     department: String,
                     id: String)
}

/// The presenter responsible for managing the add employee functionality.
class AddEmployeePresenter: AddEmployeePresenterProtocol {
    
    // Variables
    weak var view: AddEmployeeViewProtocol?
    weak var delegate: AddEmployeePresenterDelegate?
    let dataManager: CoreDataManagingProtocol
    
    required init(view: AddEmployeeViewProtocol, dataManager: CoreDataManagingProtocol) {
        self.view = view
        self.dataManager = dataManager
    }
    
    /**
     This method is responsible for adding a new employee with the provided details.
     It takes parameters such as the employee's name, last name, salary, gender, birthday, department, and id.
     It interacts with the data manager to add the employee to the data layer.
     After successful addition, it notifies the delegate by calling the didAddEmployee() method.
     Any errors that occur during the process are handled by showing an error through the view.
     */
    func addEmployee(name: String, lastName: String, salary: Float, gender: String, birthday: Date, department: String, id: String) {
        dataManager.addEmployee(name: name,
                                lastName: lastName,
                                salary: salary,
                                birthday: birthday,
                                gender: gender,
                                department: department,
                                id: id)
        delegate?.didAddEmployee()
    }
}

