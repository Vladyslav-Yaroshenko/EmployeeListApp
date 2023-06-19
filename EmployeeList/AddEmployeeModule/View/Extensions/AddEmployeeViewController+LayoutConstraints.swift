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
        salaryLabel.translatesAutoresizingMaskIntoConstraints = false
        salaryTextField.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        genderPickerView.translatesAutoresizingMaskIntoConstraints = false
        birthdayLabel.translatesAutoresizingMaskIntoConstraints = false
        birthdayPicker.translatesAutoresizingMaskIntoConstraints = false
        
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
            
            salaryLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                 constant: labelLeadingAnchorConstant),
            salaryLabel.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor,
                                             constant: labelTopAnchorConstant),
            
            salaryTextField.topAnchor.constraint(equalTo: salaryLabel.bottomAnchor),
            salaryTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                   constant: textFieldLeadingAnchorConstant),
            salaryTextField.widthAnchor.constraint(equalTo: scrollView.widthAnchor,
                                                 constant: textFieldWidthAnchorConstant),
            salaryTextField.heightAnchor.constraint(equalToConstant: textFieldHeightAnchorConstant),
            
            genderLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                 constant: labelLeadingAnchorConstant),
            genderLabel.topAnchor.constraint(equalTo: salaryTextField.bottomAnchor,
                                             constant: labelTopAnchorConstant),
            
            genderPickerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor,
                                                 constant: textFieldWidthAnchorConstant),
            genderPickerView.heightAnchor.constraint(equalTo: salaryTextField.heightAnchor, multiplier: 2),
            
            genderPickerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                 constant: textFieldLeadingAnchorConstant),
            genderPickerView.topAnchor.constraint(equalTo: genderLabel.bottomAnchor,
                                             constant: labelTopAnchorConstant),
            
            birthdayLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                   constant: labelLeadingAnchorConstant),
            birthdayLabel.topAnchor.constraint(equalTo: genderPickerView.bottomAnchor,
                                               constant: labelTopAnchorConstant),
            
            birthdayPicker.topAnchor.constraint(equalTo: birthdayLabel.bottomAnchor),
            birthdayPicker.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                   constant: textFieldLeadingAnchorConstant),
            birthdayPicker.widthAnchor.constraint(equalTo: scrollView.widthAnchor,
                                                 constant: textFieldWidthAnchorConstant),
            birthdayPicker.heightAnchor.constraint(equalToConstant: textFieldHeightAnchorConstant),
        ])
    }
}
