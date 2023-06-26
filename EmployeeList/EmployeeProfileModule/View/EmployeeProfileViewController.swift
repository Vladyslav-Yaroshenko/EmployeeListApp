//
//  EmployeeProfileViewController.swift
//  EmployeeList
//
//  Created by Vlad on 23.06.2023.
//

import UIKit


/// Class is a view controller responsible for displaying the employee profile details.
class EmployeeProfileViewController: UIViewController {

    // MARK: - Presenter
    var presenter: EmployeeProfilePresenterProtocol!
    
    // MARK: - Variables
    var personImageView: UIImageView!
    var blueView: UIView!
    var nameLabel: UILabel!
    var departmentLabel: UILabel!
    var birthdayCircle: UIImageView!
    var birthdayLabel: UILabel!
    var genderCircle: UIImageView!
    var genderLabel: UILabel!
    var salaryCircle: UIImageView!
    var salaryLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        setupConstraint()
        presenter.setEmployee()
    }
    
    // MARK: - Funcs
    
    /// This function initializes and configures the UI elements of the view, such as labels and image views,
    /// and adds them as subviews to the view hierarchy.
    private func setupUI() {
        blueView = createBackgroundView(color: .systemBlue)
        personImageView = createPersonImageView()
        nameLabel = createLabel(textColor: .white, font: .boldSystemFont(ofSize: 22))
        departmentLabel = createLabel(textColor: .black, font: .boldSystemFont(ofSize: 20))
        birthdayCircle = createCircleImageView(width: 30, height: 30)
        birthdayLabel = createLabel(textColor: .black, font: .systemFont(ofSize: 20))
        genderCircle = createCircleImageView(width: 30, height: 30)
        genderLabel = createLabel(textColor: .black, font: .systemFont(ofSize: 20))
        salaryCircle = createCircleImageView(width: 30, height: 30)
        salaryLabel = createLabel(textColor: .black, font: .systemFont(ofSize: 20))
    }
    
    /// This function creates and configures a UILabel instance with the provided text color and font, and adds it as a subview to the view.
    private func createLabel(textColor: UIColor, font: UIFont) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = textColor
        label.font = font
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }
    
    /// This function creates and configures a UIView instance with the provided background color, corner radius,
    /// and masked corners, and adds it as a subview to the view.
    private func createBackgroundView(color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        view.layer.cornerRadius = cornerRadiusForLargeUI
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)
        return view
    }
    
    /// This function creates and configures a circular UIImageView instance with a person icon as the image,
    /// and adds it as a subview to the view.
    private func createPersonImageView() -> UIImageView {
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0,
                                                  width: view.frame.width / 3,
                                                  height: view.frame.width / 3))
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.layer.borderColor = UIColor.systemBlue.cgColor
        imageView.tintColor = .systemBlue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        return imageView
    }
    
    /// This function creates and configures a circular UIImageView instance with a circle inset image, and adds it as a subview to the view.
    private func createCircleImageView(width: Int, height: Int) -> UIImageView {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0,
                                              width: width,
                                                height: height))
        imageView.image = UIImage(systemName: "circle.inset.filled")
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.tintColor = .systemBlue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        return imageView
    }
}

// MARK: - EmployeeProfileViewProtocol

extension EmployeeProfileViewController: EmployeeProfileViewProtocol {
    
    /// This method is called by the presenter to provide the employee information to be displayed.
    /// It extracts the relevant details from the employee object and updates the corresponding labels and image views with the retrieved data.
    func setupEmployeeInfo(employee: Employee?) {
        guard let name = employee?.name,
              let lastName = employee?.lastName,
              let salary = employee?.salary,
              let gender = employee?.gender,
              let birthday = employee?.birthday,
              let department = employee?.department
        else { return }
        
        nameLabel.text = name + " " + lastName
        departmentLabel.text = department
        genderLabel.text = gender
        salaryLabel.text = "$\(salary) / month"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        dateFormatter.locale = Locale(identifier: "en_UK")
        let date = dateFormatter.string(from: birthday)
        
        birthdayLabel.text = date
    }
}
