//
//  EmployeeListViewController + UITableViewDelegate.swift
//  EmployeeList
//
//  Created by Vlad on 22.06.2023.
//

import Foundation
import UIKit

//MARK: - UITableViewDelegate

extension EmployeeListViewController: UITableViewDelegate {
    
    /**
     Creates a header view with a title label displaying the department name and an info button with an info circle icon.
     The info button has a menu that shows the count of employees and the average salary for the department.
     */
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Create the header view
        let headerView = UIView()
        headerView.backgroundColor = tableView.backgroundColor
        
        // Create the title label
        let titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let departmentName = presenter.getDepartmentName(from: section) ?? ""
        titleLabel.text = departmentName
        
        // Create the info button
        let infoButton = UIButton(type: .system)
        infoButton.setImage(UIImage(systemName: "info.circle"), for: .normal)
        infoButton.tintColor = .white
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        
        let employees = presenter.getEmployeesInDepartment(section: section) ?? []
        let salary = presenter.calculateAverageSalary(employees: employees)
        
        // Create the UIActions for the menu
        let employeesAction = UIAction(title: "Count of employees: \(employees.count)", handler: { _ in })
        let salaryAction = UIAction(title: "Average salary: \(salary)", handler: { _ in })
        
        // Configure the menu for the info button
        infoButton.menu = UIMenu(title: "\(departmentName) info",
                                 children: [employeesAction, salaryAction])
        infoButton.showsMenuAsPrimaryAction = true
        
        // Add the title label and info button to the header view
        headerView.addSubview(titleLabel)
        headerView.addSubview(infoButton)
        
        // Set up the constraints
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 0),
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8),
            
            infoButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            infoButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8)
        ])
        return headerView
    }
}
