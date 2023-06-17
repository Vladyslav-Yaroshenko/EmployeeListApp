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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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

}

extension AddEmployeeViewController: AddEmployeeViewProtocol {
    func addEmployee(employee: Employee) {
        
    }
    
}
