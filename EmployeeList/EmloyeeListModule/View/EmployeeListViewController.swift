//
//  EmployeeListViewController.swift
//  EmployeeList
//
//  Created by Vlad on 16.06.2023.
//

import UIKit

class EmployeeListViewController: UIViewController {

    var presenter: EmployeeListPresenterProtocol!
    var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        
        tableView = creatTableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        setupConstraints()
        presenter.getEmployees()
    
    }
    
    //Change color for navigation bar
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
    }
    
    // Setup self view and navigation bar right item
    private func setupView() {
        view.backgroundColor = .white
        navigationItem.title = "Employee List"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self,
                                        action: #selector(addButtonTapped))
        addButton.tintColor = .systemBlue
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    // Create new module and open VC to add new employee
    @objc func addButtonTapped() {
        let addEmployeeVC = ModuleBuilder.createAddEmployeeModule()
        navigationController?.pushViewController(addEmployeeVC, animated: true)
    }
    
    // Create table view to display list of employees
    private func creatTableView() -> UITableView {
        let tableView = UITableView(frame: CGRect(), style: .insetGrouped)
        
        tableView.backgroundColor = .systemBlue
        tableView.layer.cornerRadius = 30
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        return tableView
    }
    
    // Constraints for UI elements
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}


// MARK: - EmployeeListViewProtocol

extension EmployeeListViewController: EmployeeListViewProtocol {
    func reloadData() {
        tableView.reloadData()
    }
    
    func showError() {
        
    }
    
    
}

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

//MARK: - UITableViewDataSource

extension EmployeeListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.getDeparmentCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getEmployeesInDepartment(section: section)?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let fullName = presenter.configureCellText(indexPath: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = fullName
        cell.contentConfiguration = config
        return cell
    }

}
