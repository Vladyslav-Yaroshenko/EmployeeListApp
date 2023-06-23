//
//  EmployeeListViewController + UITableViewDataSource.swift
//  EmployeeList
//
//  Created by Vlad on 22.06.2023.
//

import Foundation
import UIKit

//MARK: - UITableViewDataSource

extension EmployeeListViewController: UITableViewDataSource {
    
    // Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        let count = presenter.getDeparmentCount() ?? 0
        emptyListView.isHidden = (count == 0) ? false : true
        return count
    }
    
    // Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getEmployeesInDepartment(section: section)?.count ?? 0
    }
    
    // Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let fullName = presenter.configureCellText(indexPath: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = fullName
        
        // Create an image view and set its image
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        
        // Set the image view as the accessoryView of the cell
        cell.accessoryView = imageView
        
        cell.contentConfiguration = config
        return cell
    }
    
    // Editing style
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    // Remove rows and sections
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let id = presenter.getEmployeeID(indexPath: indexPath) else { return }
            
            presenter.removeEmployee(id: id, indexPath: indexPath)
            if presenter.getEmployeesInDepartment(section: indexPath.section)?.count == 0 {
                presenter.removeSection(section: indexPath.section)
                tableView.deleteSections(IndexSet(integer: indexPath.section), with: .fade)
            } else {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
}
