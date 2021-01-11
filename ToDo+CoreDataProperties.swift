//
//  ToDo+CoreDataProperties.swift
//  
//
//  Created by Assem on 1/10/21.
//
//

import Foundation
import CoreData


extension ToDo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDo> {
        return NSFetchRequest<ToDo>(entityName: "ToDo")
    }

    @NSManaged public var dueDate: Date?
    @NSManaged public var subtitle: String?
    @NSManaged public var title: String?

}

extension Todo : Identifiable {
    
}
