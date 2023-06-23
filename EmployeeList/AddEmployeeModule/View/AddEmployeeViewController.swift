//
//  AddEmployeeViewController.swift
//  EmployeeList
//
//  Created by Vlad on 17.06.2023.
//

import UIKit

/**
 The AddEmployeeViewController class is a view controller responsible for displaying a form to add a new employee.
 It is part of the EmployeeList project
 */
class AddEmployeeViewController: UIViewController {

    // Presenter
    var presenter: AddEmployeePresenterProtocol!
    
    // UI Elements
    var scrollView: UIScrollView!
    var nameLabel: UILabel!
    var nameTextField: UITextField!
    var lastNameLabel: UILabel!
    var lastNameTextField: UITextField!
    var salaryLabel: UILabel!
    var salaryTextField: UITextField!
    var genderLabel: UILabel!
    let genders = ["Male", "Female", "Other"]
    var genderPickerView: PickerView!
    var birthdayLabel: UILabel!
    var birthdayPicker: UITextField!
    var selectedDate: Date?
    var departmentLabel: UILabel!
    var depatmentMenu: UITextField!
    var saveButton: UIButton!
    var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupUI()
        activateConstraints()
    }
    
    /// Method is overridden to adjust the content size of the scrollView based on the subviews' layout.
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // Set the contentSize of the scrollView to fit the subviews
        scrollView.contentSize = CGSize(width: view.bounds.width, height: cancelButton.frame.maxY)
    }
    
    /// Defines private methods to set up and configure the UI elements, including creating labels, text fields, pickers, buttons, etc.
    private func setupUI() {
        scrollView = createScrollView()
        nameLabel = createLabel(text: "Name", textColor: .black)
        nameTextField = createTextField(placeholder: "Please enter name")
        lastNameLabel = createLabel(text: "Last name", textColor: .black)
        lastNameTextField = createTextField(placeholder: "Please enter last name")
        salaryLabel = createLabel(text: "Salary", textColor: .black)
        salaryTextField = createSalaryTextField()
        genderLabel = createLabel(text: "Gender", textColor: .black)
        genderPickerView = createGenderView()
        birthdayLabel = createLabel(text: "Birthday", textColor: .black)
        birthdayPicker = createDatePicker()
        departmentLabel = createLabel(text: "Department", textColor: .black)
        depatmentMenu = createDepartmentMenu()
        saveButton = createButton(title: "Save", titleColor: .white, backgroundColor: .systemBlue)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        cancelButton = createButton(title: "Cancel", titleColor: .systemBlue, backgroundColor: .white)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    
    /// Creates a text field specifically for salary input, including a decimal pad keyboard and a toolbar with a "Done" button.
    private func createSalaryTextField() -> UITextField {
        let tf = createTextField(placeholder: "Please enter salary")
        tf.keyboardType = .decimalPad
        
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(salaryDoneButtonPressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [flexibleSpace, doneButton]
        
        tf.inputAccessoryView = toolbar
        return tf
    }
    
    /// Simply dismisses the keyboard when the user is done entering the salary value in the text field.
    @objc func salaryDoneButtonPressed() {
        salaryTextField.resignFirstResponder()
    }
    
    /// Func sets up the overall view appearance, including the title and navigation bar settings.
    private func setupView() {
        view.backgroundColor = .systemBlue
        title = "Add a new employee"
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
        ]
        navigationController?.navigationBar.tintColor = .white
    }
    
    /// Creates a scroll view and adds it as a subview to the main view.
    private func createScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.layer.cornerRadius = cornerRadiusForLargeUI
        scrollView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.addSubview(scrollView)
        return scrollView
    }
    
    /// Creates a label with the given text and text color and adds it as a subview to the scroll view.
    private func createLabel(text: String, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = textColor
        label.font = labelFont
        scrollView.addSubview(label)
        return label
    }
    
    /// Creates a text field with the given placeholder text and adds it as a subview to the scroll view.
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
    
    /// Creates a custom view (PickerView) to display gender options.
    private func createGenderView() -> PickerView {
        let genderView = PickerView()
        genderView.dataSource = self
        scrollView.addSubview(genderView)
        return genderView
    }
    
    /// Creates a date picker with a text field for selecting the employee's birthday.
    private func createDatePicker() -> UITextField {
       
        // Create toolbar with done button
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [flexibleSpace, doneButton]

        // Crate date picker
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = Date()
        datePicker.locale = Locale(identifier: "en_UK")

        let textField = createTextField(placeholder: "Please enter birthday")
        textField.inputAccessoryView = toolbar
        textField.inputView = datePicker

        scrollView.addSubview(textField)
        return textField
    }
    
    /// Retrieves the selected date from the date picker, formats it into a string, displays it in the text field,
    /// and dismisses the date picker's keyboard.
    @objc private func doneButtonPressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        dateFormatter.locale = Locale(identifier: "en_UK")
        let datePicker = birthdayPicker.inputView as? UIDatePicker
        guard let selectedDate = datePicker?.date else { return }
        self.selectedDate = selectedDate
        let formattedDate = dateFormatter.string(from: selectedDate)
        birthdayPicker.text = formattedDate
        birthdayPicker.resignFirstResponder()
    }
    
    /// Creates a text field with a drop-down menu for selecting the department.
    private func createDepartmentMenu() -> UITextField {
        let textField = createTextField(placeholder: "Select department")
        
        let dropDownButton = UIButton(type: .system)
        dropDownButton.setImage(UIImage(systemName: "chevron.down")?.withTintColor(.systemBlue), for: .normal)
        dropDownButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        
        let menuChildren = Departament.allCases.map { devCase in
            return UIAction(title: devCase.rawValue) { _ in
                textField.text = devCase.rawValue
            }
        }
        
        textField.rightView = dropDownButton
        textField.rightViewMode = .always
    
        dropDownButton.menu = UIMenu(children: menuChildren)
        dropDownButton.showsMenuAsPrimaryAction = true
    
        return textField
    }

    /// Creates a button with the given title, title color, and background color.
    private func createButton(title: String, titleColor: UIColor, backgroundColor: UIColor) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = cornerRadius
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = backgroundColor
        scrollView.addSubview(button)
        return button
    }
    
    /// Method is called when the save button is tapped.
    /// It retrieves the input values from the UI elements, validates them,
    /// and then calls the presenter's addEmployee method to add the employee.
    @objc private func saveButtonTapped() {
        guard let name = nameTextField.text,
              let lastName = lastNameTextField.text,
              let salaryText = salaryTextField.text,
              let salary = Float(salaryText),
              let gender = genderPickerView.selectedItem,
              let birthday = selectedDate,
              let department = depatmentMenu.text,
              !name.isEmpty,
              !lastName.isEmpty,
              !salaryText.isEmpty,
              !gender.isEmpty,
              !department.isEmpty
        else {
            showError()
            return
        }
        
        // Creates a unique identifier
        let id = UUID().uuidString
        
        presenter.addEmployee(name: name,
                              lastName: lastName,
                              salary: salary,
                              gender: gender,
                              birthday: birthday,
                              department: department,
                              id: id)
        
        navigationController?.popViewController(animated: true)
    }
    
    /// Method is called when the cancel button is tapped. It simply pops the view controller from the navigation stack.
    @objc private func cancelButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}


// MARK: - AddEmployeeViewProtocol
extension AddEmployeeViewController: AddEmployeeViewProtocol {
    
    /// Displays an error message if any required fields are not filled out when saving the employee.
    func showError() {
        let alertVC = UIAlertController(title: "The employee is not saved",
                                        message: "Fill out all fields to save",
                                        preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertVC.addAction(okAction)
        present(alertVC, animated: true)
    }
}

// MARK: - UITextViewDelegate
extension AddEmployeeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return textField == depatmentMenu ? false : true
    }
    
}
