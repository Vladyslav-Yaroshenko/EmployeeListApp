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
    var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupUI()
        activateConstraints()
    }
    
    private func setupUI() {
        scrollView = createScrollView()
        nameLabel = createLabel(text: "Name", textColor: .black)
        nameTextField = createTextField(placeholder: "Please enter name")
        
        
        
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
    
    // Create text field
    private func createTextField(placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.placeholder = placeholder
        let leftMarginView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = leftMarginView
        tf.leftViewMode = .always
        tf.layer.cornerRadius = cornerRadius
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.systemBlue.cgColor
        tf.delegate = self
        scrollView.addSubview(tf)
        return tf
    }

}


// MARK: - AddEmployeeViewProtocol
extension AddEmployeeViewController: AddEmployeeViewProtocol {
    func addEmployee(employee: Employee) {
        
    }
    
}

// MARK: - NSLayoutConstraint
extension AddEmployeeViewController {
    
    func activateConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: labelLeadingAnchorConstant),
            nameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: labelTopAnchorConstant),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                   constant: textFieldLeadingAnchorConstant),
            nameTextField.widthAnchor.constraint(equalTo: scrollView.widthAnchor,
                                                 constant: textFieldWidthAnchorConstant),
            nameTextField.heightAnchor.constraint(equalToConstant: textFieldHeightAnchorConstant)
        ])
    }
}

// MARK: - UITextViewDelegate
extension AddEmployeeViewController: UITextFieldDelegate {
    
}
