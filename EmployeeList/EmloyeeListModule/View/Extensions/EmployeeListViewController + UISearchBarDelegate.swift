//
//  EmployeeListViewController + UISearchBarDelegate.swift
//  EmployeeList
//
//  Created by Vlad on 22.06.2023.
//

import Foundation
import UIKit

extension EmployeeListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.filterEmployees(with: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.filterEmployees(with: "")
    }
}
