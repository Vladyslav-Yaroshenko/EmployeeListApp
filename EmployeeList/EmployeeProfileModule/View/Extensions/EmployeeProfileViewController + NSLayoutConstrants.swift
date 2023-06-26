//
//  EmployeeProfileViewController + NSLayoutConstrants.swift
//  EmployeeList
//
//  Created by Vlad on 26.06.2023.
//

import Foundation
import UIKit

// MARK: - NSLayoutConstraint

extension EmployeeProfileViewController {
     func setupConstraint() {
 
        NSLayoutConstraint.activate([
            blueView.topAnchor.constraint(equalTo: view.topAnchor),
            blueView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blueView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blueView.bottomAnchor.constraint(equalTo: personImageView.centerYAnchor),
            
            personImageView.widthAnchor.constraint(equalToConstant: view.frame.width / 3),
            personImageView.heightAnchor.constraint(equalToConstant: view.frame.width / 3),
            personImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            personImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: personImageView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: personImageView.topAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameLabel.bottomAnchor.constraint(equalTo: blueView.bottomAnchor),
            
            departmentLabel.topAnchor.constraint(equalTo: blueView.bottomAnchor),
            departmentLabel.leadingAnchor.constraint(equalTo: personImageView.trailingAnchor, constant: 16),
            departmentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -16),
            departmentLabel.bottomAnchor.constraint(equalTo: personImageView.bottomAnchor),
            
            birthdayCircle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            birthdayCircle.topAnchor.constraint(equalTo: personImageView.bottomAnchor, constant: 50),
            birthdayCircle.widthAnchor.constraint(equalToConstant: 30),
            birthdayCircle.heightAnchor.constraint(equalToConstant: 30),
            
            birthdayLabel.leadingAnchor.constraint(equalTo: birthdayCircle.trailingAnchor, constant: 8),
            birthdayLabel.topAnchor.constraint(equalTo: birthdayCircle.topAnchor),
            birthdayLabel.heightAnchor.constraint(equalTo: birthdayCircle.heightAnchor),
            
            genderCircle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            genderCircle.topAnchor.constraint(equalTo: birthdayCircle.bottomAnchor, constant: 30),
            genderCircle.widthAnchor.constraint(equalToConstant: 30),
            genderCircle.heightAnchor.constraint(equalToConstant: 30),
            
            genderLabel.leadingAnchor.constraint(equalTo: genderCircle.trailingAnchor, constant: 8),
            genderLabel.topAnchor.constraint(equalTo: genderCircle.topAnchor),
            genderLabel.heightAnchor.constraint(equalTo: genderCircle.heightAnchor),
            
            salaryCircle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            salaryCircle.topAnchor.constraint(equalTo: genderCircle.bottomAnchor, constant: 30),
            salaryCircle.widthAnchor.constraint(equalToConstant: 30),
            salaryCircle.heightAnchor.constraint(equalToConstant: 30),
            
            salaryLabel.leadingAnchor.constraint(equalTo: salaryCircle.trailingAnchor, constant: 8),
            salaryLabel.topAnchor.constraint(equalTo: salaryCircle.topAnchor),
            salaryLabel.heightAnchor.constraint(equalTo: salaryCircle.heightAnchor)
        ])
    }
}
