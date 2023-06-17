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
        let tableView = UITableView()
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
        
    }
    
    func showError() {
        
    }
    
    
}

//MARK: - UITableViewDelegate

extension EmployeeListViewController: UITableViewDelegate {
    
}

//MARK: - UITableViewDataSource

extension EmployeeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}
