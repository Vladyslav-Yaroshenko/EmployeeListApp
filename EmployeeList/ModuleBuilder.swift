//
//  ModuleBuilder.swift
//  EmployeeList
//
//  Created by Vlad on 16.06.2023.
//

import Foundation
import UIKit

/**
 ModuleBuilderProtocol is a protocol that defines static methods for creating view controllers.
 These methods must return instances of the UIViewController.
 */
protocol ModuleBuilderProtocol {
    static func createEmployeeListModule() -> UIViewController
    static func createAddEmployeeModule() -> UIViewController
}

/**
 The ModuleBuilder class is a concrete implementation of ModuleBuilderProtocol.
 It serves as a factory for creating and configuring view controllers related to the employee list module.
 It ensures that the necessary connections between the views and presenters are established.
 */
class ModuleBuilder: ModuleBuilderProtocol {

    private static var presenterDelegate: AddEmployeePresenterDelegate?
    
    /**
     The createEmployeeListModule() method is a static method that creates and configures an instance of EmployeeListViewController.
     It also creates an instance of EmployeeListPresenter, passing the view and a shared CoreDataManager instance.
     The presenter is then assigned to the view's presenter property, establishing the connection between them.
     Finally, the delegate of the presenter is assigned to the presenterDelegate variable, storing the reference for future use.
     The method returns the created EmployeeListViewController.
     */
    static func createEmployeeListModule() -> UIViewController {
        let view = EmployeeListViewController()
        let presenter = EmployeeListPresenter(view: view,
                                              dataManager: CoreDataManager.shared)
        view.presenter = presenter
        presenterDelegate = presenter.delegate
        return view
    }
    
    
    /**
     The createAddEmployeeModule() method is another static method that creates and configures an instance of AddEmployeeViewController.
     It also creates an instance of AddEmployeePresenter, passing the view and a shared CoreDataManager instance.
     Similar to the previous method, the presenter is assigned to the view's presenter property.
     Additionally, the delegate of the presenter is assigned the value stored in the presenterDelegate variable,
     ensuring the same delegate instance is used. The method returns the created AddEmployeeViewController.
     */
    static func createAddEmployeeModule() -> UIViewController {
        let view = AddEmployeeViewController()
        let presenter = AddEmployeePresenter(view: view,
                                             dataManager: CoreDataManager.shared)
        view.presenter = presenter
        presenter.delegate = presenterDelegate
        return view
    }
}
