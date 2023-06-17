//
//  AddEmployeePresenter.swift
//  EmployeeList
//
//  Created by Vlad on 17.06.2023.
//


protocol AddEmployeeViewProtocol: AnyObject {
    func addEmployee(employee: Employee)
}

protocol AddEmployeePresenterProtocol: AnyObject {
    init(view: AddEmployeeViewProtocol, dataManager: CoreDataManagingProtocol)
}


class AddEmployeePresenter: AddEmployeePresenterProtocol {
    
    weak var view: AddEmployeeViewProtocol?
    let dataManager: CoreDataManagingProtocol
    
    required init(view: AddEmployeeViewProtocol, dataManager: CoreDataManagingProtocol) {
        self.view = view
        self.dataManager = dataManager
    }
}
