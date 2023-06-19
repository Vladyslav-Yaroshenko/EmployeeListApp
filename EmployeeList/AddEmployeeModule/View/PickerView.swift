//
//  PickerView.swift
//  EmployeeList
//
//  Created by Vlad on 17.06.2023.
//

// MARK: - Description
// Custom UI element for displaying a picker view with selectable buttons.
// The `PickerView` class provides a customizable picker view interface with selectable buttons.
// It allows users to choose an option by tapping on a button.
// The picker view can be populated with data through the `PickerViewDataSource` protocol.

import Foundation
import UIKit

// MARK: - PickerViewDataSource
protocol PickerViewDataSource: AnyObject {
    func numberOfObjects(in pickerView: PickerView) -> Int
    func numberOfItemsPerRow(in pickerView: PickerView) -> Int
    func pickerView(_ pickerView: PickerView, titleForItemAt indexPath: IndexPath) -> String
}


// MARK: - PickerView
class PickerView: UIControl {
    weak var dataSource: PickerViewDataSource? {
        didSet {
            setupView()
        }
    }
    
    // MARK: - Variables
    private var buttons: [UIButton] = []
    private var stackView: UIStackView!
    private var selectedItem: String?
    
    // Override the layoutSubviews() method to update the stack view's frame
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     The setupView() method is responsible for setting up the picker view by creating the necessary UI elements.
     This method populates the picker view with buttons based on the data source provided.
     It creates a main stack view to hold the rows of buttons, and within each row, it creates buttons based on the number of items per row.
     The buttons are configured with titles and added to the appropriate stack views.
     */
    func setupView() {
        guard let count = dataSource?.numberOfObjects(in: self),
              let itemsPerRow = dataSource?.numberOfItemsPerRow(in: self)
        else { return }
        
        stackView = UIStackView()
        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        var currentRowStackView: UIStackView?
        
        for item in 0..<count {
            if item % itemsPerRow == 0 {
                currentRowStackView = UIStackView()
                currentRowStackView?.spacing = 16
                currentRowStackView?.axis = .horizontal
                currentRowStackView?.alignment = .center
                currentRowStackView?.distribution = .fillEqually
                stackView.addArrangedSubview(currentRowStackView!)
            }
            
            let indexPath = IndexPath(row: item, section: 0)
            let title = dataSource?.pickerView(self, titleForItemAt: indexPath)
            let button = createButton(withTitle: title)
            
            button.tag = item
            button.addTarget(self, action: #selector(selectedButton(_:)), for: .touchUpInside)
            
            currentRowStackView?.addArrangedSubview(button)
            buttons.append(button)
        }
    }
    
    /**
     Creates and configures a button with the specified title.
     */
    private func createButton(withTitle title: String?) -> UIButton {
        let button = UIButton(type: .custom)
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        if #available(iOS 15.0, *) {
            button.configuration = createButtonConfiguration(withTitle: title)
        } else {
            button.setTitle(title, for: .normal)
            button.setImage(UIImage(systemName: "circle")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal), for: .normal)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
            button.contentHorizontalAlignment = .center
            button.contentVerticalAlignment = .center
        }
        
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 20
        
        return button
    }
    
    /** Creates and returns a button configuration with the specified title.
    This method is used to create a button configuration for iOS 15 and later versions. It configures the button's title, image, image padding, placement, and title alignment.
     */
    @available(iOS 15.0, *)
    private func createButtonConfiguration(withTitle title: String?) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.plain()
        configuration.title = title
        configuration.image = UIImage(systemName: "circle")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        configuration.imagePadding = 8
        configuration.imagePlacement = .leading
        configuration.titleAlignment = .center
        return configuration
    }
    
    /**
     Handles the button selection event.
     
     This method is called when a button in the `PickerView` is selected. It updates the appearance of the selected button and tracks the selected item.
     */
    @objc private func selectedButton(_ sender: UIButton) {
        for button in buttons {
            if #available(iOS 15.0, *) {
                button.configuration?.image = UIImage(systemName: "circle")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
            }
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.lightGray.cgColor
        }
        
        let index = sender.tag
        let button = buttons[index]
        
        if #available(iOS 15.0, *) {
            button.configuration?.image = UIImage(systemName: "checkmark.circle.fill")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
        }
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.systemBlue.cgColor
        selectedItem = button.titleLabel?.text
    }
}
