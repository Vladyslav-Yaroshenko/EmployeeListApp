//
//  EmployeeProfileViewController.swift
//  EmployeeList
//
//  Created by Vlad on 23.06.2023.
//

import UIKit

class EmployeeProfileViewController: UIViewController {

    var presenter: EmployeeProfilePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension EmployeeProfileViewController: EmployeeProfileViewProtocol {
    func setupEmployeeInfo(employee: Employee?) {
        print("1")
    }
    
    
}
