//
//  AddEmployeeViewController.swift
//  EmployeeList
//
//  Created by Vlad on 17.06.2023.
//

import UIKit

class AddEmployeeViewController: UIViewController {

    var presenter: AddEmployeePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}

extension AddEmployeeViewController: AddEmployeeViewProtocol {
    func addEmployee(employee: Employee) {
        
    }
    
}
