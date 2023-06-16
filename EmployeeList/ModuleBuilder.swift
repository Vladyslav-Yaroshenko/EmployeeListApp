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
}


class ModuleBuilder: ModuleBuilderProtocol {

    static func createEmployeeListModule() -> UIViewController {
        let view = EmployeeListViewController()
        let presenter = EmployeeListPresenter(view: view,
                                              dataManager: CoreDataManager.shared)
        view.presenter = presenter
        return view
    }
}
