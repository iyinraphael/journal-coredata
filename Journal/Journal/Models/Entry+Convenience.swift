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
    
    var entryRepresentation: EntryRepresentation? {
        guard let id = identifier, let title = title, let timestamp = timestamp, let mood = mood else {
            return nil }
        
        return EntryRepresentation(title: title, bodyText: bodyText, timestamp: timestamp, identifier: id.uuidString, mood: mood)
    }
    
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
    
    @discardableResult convenience init?(entryRepresentation: EntryRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        guard let uuid = UUID(uuidString: entryRepresentation.identifier),
            let mood = Mood(rawValue: entryRepresentation.mood) else { return nil }
        
        self.init(title: entryRepresentation.title, bodyText: entryRepresentation.bodyText, timestamp: entryRepresentation.timestamp, identifier: uuid, mood: mood, context: context)
        
    }
}
