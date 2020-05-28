//
//  CoreDataStack.swift
//  Journal
//
//  Created by Iyin Raphael on 5/27/20.
//  Copyright © 2020 Iyin Raphael. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()
       
       var container: NSPersistentContainer = {
           let container = NSPersistentContainer(name: "Journal")
           container.loadPersistentStores { _, error in
               if let error = error {
                   fatalError("Failed to load persistent stores: \(error)")
               }
           }
           
           return container
       }()
       
       var mainContext: NSManagedObjectContext {
           return container.viewContext
       }
    
}
