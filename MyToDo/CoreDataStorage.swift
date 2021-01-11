//
//  CoreDataStorage.swift
//  MyToDo
//
//  Created by Assem on 1/10/21.
//  Copyright © 2021 Assem. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataStorage {

    private let container: NSPersistentContainer


    init() {
        container = NSPersistentContainer(name: "MyToDo")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
    }

    func save(title: String, subtitle: String, date: Date) {
        let item = ToDo(context: container.viewContext)
        item.title = title
        item.subtitle = subtitle
        item.dueDate = date

        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                container.viewContext.rollback()
            }
        }
    }

    func fetchToDoItems() -> [ToDo] {
        let fetchRequest: NSFetchRequest<ToDo> = ToDo.fetchRequest()
        //let predicate = NSPredicate(format: "%K BEGINSWITH[cd] %@", #keyPath(ToDo.title), "убо")
        do {
            return try container.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }

    func delete(item: ToDo) {
        container.viewContext.delete(item)
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                container.viewContext.rollback()
            }
        }
    }

    func update() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                container.viewContext.rollback()
            }
        }
    }



}
