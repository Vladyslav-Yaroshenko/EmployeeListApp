//
//  CoreDataManager.swift
//  EmployeeList
//
//  Created by Vlad on 16.06.2023.
//

import CoreData
import UIKit

// MARK: - CoreDataManagingProtocol

/// Protocol defining the required methods for managing Core Data operations.
protocol CoreDataManagingProtocol {
    func addEmployee(name: String,
                     lastName: String,
                     salary: Float,
                     birthday: Date,
                     gender: String,
                     department: String)
    
    func fetchEmployees() -> [Employee]?
}

// MARK: - CoreDataManager

/// Class responsible for managing Core Data operations.
class CoreDataManager: CoreDataManagingProtocol {
    
    public static let shared = CoreDataManager()
    private init() {}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    private let entityName = "Employee"
    
    // Add new employee to core data
    public func addEmployee(name: String,
                            lastName: String,
                            salary: Float,
                            birthday: Date,
                            gender: String,
                            department: String) {
        guard let employeeEntityDescription = NSEntityDescription.entity(forEntityName: entityName,
                                                                         in: context)
        else { return }
        let employee = Employee(entity: employeeEntityDescription,
                                insertInto: context)
        employee.name = name
        employee.lastName = lastName
        employee.salary = salary
        employee.birthday = birthday
        employee.gender = gender
        employee.department = department
        
        appDelegate.saveContext()
    }
    
    // Fetch all employees from core data
    func fetchEmployees() -> [Employee]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            return (try? context.fetch(fetchRequest) as? [Employee]) ?? []
        }
    }
}
