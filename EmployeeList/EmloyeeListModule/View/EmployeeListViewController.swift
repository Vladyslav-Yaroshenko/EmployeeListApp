//
//  EmployeeListViewController.swift
//  EmployeeList
//
//  Created by Vlad on 16.06.2023.
//

import UIKit

/**
 A view controller responsible for displaying a list of employees.
  
 The view controller conforms to the `EmployeeListViewProtocol` to handle data updates and error handling.
 The view controller communicates with the presenter through the `presenter` property.
 It contains a `tableView` to display the list of employees and an `emptyListView` to show a message when the list is empty.
 */
class EmployeeListViewController: UIViewController {

    // MARK: - Variables
    var presenter: EmployeeListPresenterProtocol!
    var tableView: UITableView!
    var emptyListView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        tableView = creatTableView()
        emptyListView = createEmptyListView()
        setupConstraints()
        presenter.getEmployees()
    }
    
    /**
     Creates and configures a view to display an empty list message with an image and label.
     The view is added as a subview to the table view.
     */
    private func createEmptyListView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomLabel = UILabel()
        bottomLabel.textColor = .white
        bottomLabel.text = "List is empty"
        bottomLabel.font = UIFont.boldSystemFont(ofSize: 30)
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomLabel)
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "list.bullet.clipboard")?.withTintColor(.white)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.widthAnchor.constraint(equalTo: bottomLabel.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: bottomLabel.widthAnchor),
            
            bottomLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            bottomLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.addSubview(view)
        return view
    }
    
    /**
     Sets up a search controller in the navigation bar for filtering the employee list.
     */
    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        
        searchController.searchBar.searchTextField.backgroundColor = .lightText
        searchController.searchBar.tintColor = .black
    
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    /**
     Overrides the viewWillAppear method to customize the appearance of the navigation bar.
     */
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
    }
    
    /**
     Sets up the view and navigation bar for the EmployeeListViewController.
     */
    private func setupView() {
        view.backgroundColor = .white
        navigationItem.title = "Employee List"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self,
                                        action: #selector(addButtonTapped))
        addButton.tintColor = .systemBlue
        self.navigationItem.rightBarButtonItem = addButton
        setupSearchController()
    }
    
    /**
    Called when the "Add" button in the navigation bar is tapped.
    Creates a new instance of the AddEmployeeViewController using the ModuleBuilder.
    Pushes the AddEmployeeViewController onto the navigation stack to open the screen for adding a new employee.
     */
    @objc func addButtonTapped() {
        let addEmployeeVC = ModuleBuilder.createAddEmployeeModule()
        navigationController?.pushViewController(addEmployeeVC, animated: true)
    }
    
    /**
     Creates and configures a UITableView to display the list of employees.
     */
    private func creatTableView() -> UITableView {
        let tableView = UITableView(frame: CGRect(), style: .insetGrouped)
        
        tableView.backgroundColor = .systemBlue
        tableView.layer.cornerRadius = 30
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }
    
    /**
     Sets up the constraints for the UI elements in the EmployeeListViewController.
     */
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        emptyListView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emptyListView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            emptyListView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor)
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


