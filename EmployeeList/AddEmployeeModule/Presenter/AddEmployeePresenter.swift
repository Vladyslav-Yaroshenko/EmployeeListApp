//
//  AddEmployeePresenter.swift
//  EmployeeList
//
//  Created by Vlad on 17.06.2023.
//

import Foundation


protocol AddEmployeeViewProtocol: AnyObject {
    func showError()
}

protocol AddEmployeePresenterProtocol: AnyObject {
    init(view: AddEmployeeViewProtocol, dataManager: CoreDataManagingProtocol)
    func addEmployee(name: String,
                     lastName: String,
                     salary: Float,
                     gender: String,
                     birthday: Date,
                     department: String)
}


class AddEmployeePresenter: AddEmployeePresenterProtocol {
    
    weak var view: AddEmployeeViewProtocol?
    let dataManager: CoreDataManagingProtocol
    
    required init(view: AddEmployeeViewProtocol, dataManager: CoreDataManagingProtocol) {
        self.view = view
        self.dataManager = dataManager
    }
    
    func addEmployee(name: String, lastName: String, salary: Float, gender: String, birthday: Date, department: String) {
        dataManager.addEmployee(name: name,
                                lastName: lastName,
                                salary: salary,
                                birthday: birthday,
                                gender: gender,
                                department: department)
    }
    
}

