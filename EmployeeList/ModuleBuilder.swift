//
//  ModuleBuilder.swift
//  EmployeeList
//
//  Created by Vlad on 16.06.2023.
//

import Foundation
import UIKit

protocol ModuleBuilderProtocol {
    static func createEmployeeListModule() -> UIViewController
    static func createAddEmployeeModule() -> UIViewController
}


class ModuleBuilder: ModuleBuilderProtocol {

    private static var presenterDelegate: AddEmployeePresenterDelegate?
    
    static func createEmployeeListModule() -> UIViewController {
        let view = EmployeeListViewController()
        let presenter = EmployeeListPresenter(view: view,
                                              dataManager: CoreDataManager.shared)
        view.presenter = presenter
        presenterDelegate = presenter.delegate
        return view
    }
    
    static func createAddEmployeeModule() -> UIViewController {
        let view = AddEmployeeViewController()
        let presenter = AddEmployeePresenter(view: view,
                                             dataManager: CoreDataManager.shared)
        view.presenter = presenter
        presenter.delegate = presenterDelegate
        return view
    }
}
