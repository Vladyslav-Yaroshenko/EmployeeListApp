//
//  EmployeeListViewController.swift
//  EmployeeList
//
//  Created by Vlad on 16.06.2023.
//

import UIKit

class EmployeeListViewController: UIViewController {

    var presenter: EmployeeListPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

extension EmployeeListViewController: EmployeeListViewProtocol {
    func reloadData() {
        
    }
    
    func showError() {
        
    }
    
    
}
