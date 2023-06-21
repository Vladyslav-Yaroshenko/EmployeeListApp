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
    
    private func createButton() -> UIButton {
        let button = UIButton(type: .custom)
        
        if #available(iOS 15.0, *) {
            button.configuration = createButtonConfiguration()
        } else {
            button.setImage(UIImage(systemName: "chevron.down")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
            button.contentHorizontalAlignment = .center
            button.contentVerticalAlignment = .center
        }
        
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 20
        button.isEnabled = false
        return button
    }
    
    @available(iOS 15.0, *)
    private func createButtonConfiguration() -> UIButton.Configuration {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "chevron.down")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        configuration.imagePadding = 8
        configuration.imagePlacement = .leading
        configuration.titleAlignment = .center
        return configuration
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        let headerView = UIView()
        headerView.backgroundColor = tableView.backgroundColor
        
        let titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let departmentName = presenter.getDepartmentName(from: section)
        titleLabel.text = (departmentName ?? "")
        
        let infoButton = createButton()
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        infoButton.layer.borderColor = tableView.backgroundColor?.cgColor
        infoButton.tag = section
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        
            
        headerView.addSubview(titleLabel)
        headerView.addSubview(infoButton)
        
        
        NSLayoutConstraint.activate([
            
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 0),
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8),
            
            infoButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            infoButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8)
            
            
//            countLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
//            countLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
//            countLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8)
        ])
        
        return headerView
    }
    
    @objc func infoButtonTapped(sender: UIButton) {
        let headerView = tableView.headerView(forSection: sender.tag)
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
