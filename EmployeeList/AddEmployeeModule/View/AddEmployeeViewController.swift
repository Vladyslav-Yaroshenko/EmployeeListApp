//
//  AddEmployeeViewController.swift
//  EmployeeList
//
//  Created by Vlad on 17.06.2023.
//

import UIKit

class AddEmployeeViewController: UIViewController {

    // Presenter
    var presenter: AddEmployeePresenterProtocol!
    
    // UI Elements
    var scrollView: UIScrollView!
    var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupUI()
        activateConstraints()
    }
    
    private func setupUI() {
        scrollView = createScrollView()
        
        nameLabel = createLabel(text: "Name", textColor: .black)
        
        
        
    }
    
    private func setupView() {
        view.backgroundColor = .systemBlue
        title = "Add a new employee"
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
        ]
        navigationController?.navigationBar.tintColor = .white
    }
    
    // Create scrollView 
    private func createScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.layer.cornerRadius = cornerRadiusForLargeUI
        scrollView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.addSubview(scrollView)
        return scrollView
    }
    
    // Create label
    private func createLabel(text: String, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = textColor
        label.font = labelFont
        scrollView.addSubview(label)
        return label
    }

}

extension AddEmployeeViewController: AddEmployeeViewProtocol {
    func addEmployee(employee: Employee) {
        
    }
    
}

extension AddEmployeeViewController {
    
    func activateConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: labelLeadingAnchorConstant),
            nameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: labelTopAnchorConstant)
        ])
    }
}
