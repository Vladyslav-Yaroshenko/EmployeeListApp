//
//  AddEmployeeViewController+PickerViewDataSource.swift
//  EmployeeList
//
//  Created by Vlad on 17.06.2023.
//

import Foundation

extension AddEmployeeViewController: PickerViewDataSource {
    func numberOfObjects(in pickerView: PickerView) -> Int {
        return 3
    }
    
    func numberOfItemsPerRow(in pickerView: PickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: PickerView, titleForItemAt indexPath: IndexPath) -> String {
        return genders[indexPath.row]
    }
    
    
}
