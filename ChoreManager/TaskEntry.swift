//
//  TaskEntry.swift
//  ChoreManager
//
//  Created by Akash on 12/19/20.
//

import Foundation
import CoreData

public class TaskEntry: NSManagedObject, Identifiable {
    @NSManaged public var dueDate: Date?
    @NSManaged public var isCompleted: String? //0 for incomplete, 1 for complete
    @NSManaged public var name: String?
    @NSManaged public var taskDescr: String?
    @NSManaged public var usersList: String?
}

extension TaskEntry {
    static func getAllRecords() -> NSFetchRequest<TaskEntry> {
        let request: NSFetchRequest<TaskEntry> = TaskEntry.fetchRequest() as! NSFetchRequest<TaskEntry>
        
        let sortDescriptor = NSSortDescriptor(key: "dueDate", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        return request
    }
}
