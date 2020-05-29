//
//  Entry+Convenience.swift
//  Journal
//
//  Created by Iyin Raphael on 5/27/20.
//  Copyright © 2020 Iyin Raphael. All rights reserved.
//

import Foundation
import CoreData

enum Mood: String, CaseIterable {
    case normal = "😐"
    case sad = "☹️"
    case happy = "🙂"
}

extension Entry {
    
    @discardableResult convenience init(title: String,
                                        bodyText: String? = nil,
                                        timestamp: Date = Date(),
                                        identifier: UUID = UUID(),
                                        mood: Mood = .normal,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.title = title
        self.bodyText = bodyText
        self.timestamp = timestamp
        self.identifier = identifier
        self.mood = mood.rawValue
    }
}
