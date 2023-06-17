//
//  AddEmployeeViewController+LayoutConstraints.swift
//  EmployeeList
//
//  Created by Vlad on 17.06.2023.
//

import UIKit

extension AddEmployeeViewController {
    
    func activateConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        lastNameLabel.translatesAutoresizingMaskIntoConstraints = false
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                               constant: labelLeadingAnchorConstant),
            nameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor,
                                           constant: labelTopAnchorConstant),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                   constant: textFieldLeadingAnchorConstant),
            nameTextField.widthAnchor.constraint(equalTo: scrollView.widthAnchor,
                                                 constant: textFieldWidthAnchorConstant),
            nameTextField.heightAnchor.constraint(equalToConstant: textFieldHeightAnchorConstant),
            
            lastNameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                   constant: labelLeadingAnchorConstant),
            lastNameLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor,
                                               constant: labelTopAnchorConstant),
            
            lastNameTextField.topAnchor.constraint(equalTo: lastNameLabel.bottomAnchor),
            lastNameTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                   constant: textFieldLeadingAnchorConstant),
            lastNameTextField.widthAnchor.constraint(equalTo: scrollView.widthAnchor,
                                                 constant: textFieldWidthAnchorConstant),
            lastNameTextField.heightAnchor.constraint(equalToConstant: textFieldHeightAnchorConstant),
        ])
    }
}
