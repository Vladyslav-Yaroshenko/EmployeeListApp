//
//  EmployeeProfilePresenter.swift
//  EmployeeList
//
//  Created by Vlad on 23.06.2023.
//

import Foundation

protocol EmployeeProfileViewProtocol: AnyObject {
    func setupEmployeeInfo()
}

protocol EmployeeProfilePresenterProtocol: AnyObject {
    init(view: EmployeeProfileViewProtocol, dataManager: CoreDataManagingProtocol)
    func setEmployee()
}

class EmployeeProfilePresenter: EmployeeProfilePresenterProtocol {
    
    weak var view: EmployeeProfileViewProtocol?
    var dataManager: CoreDataManagingProtocol!
    
    required init(view: EmployeeProfileViewProtocol, dataManager: CoreDataManagingProtocol) {
        self.view = view
        self.dataManager = dataManager
    }
    
    func setEmployee() {
        <#code#>
    }
    
    
}
