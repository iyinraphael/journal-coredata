//
//  EntryController.swift
//  Journal
//
//  Created by Iyin Raphael on 6/1/20.
//  Copyright © 2020 Iyin Raphael. All rights reserved.
//

import Foundation
import CoreData

enum NetWorkError: Error {
    case noIdentifier
    case otherError
    case noData
    case faliedDecode
    case failedEncode
}


class EntryController {
    
    let baseURL = URL(string: "https://journal-93b2b.firebaseio.com/")!
    
    typealias CompleteHandler = (Result<Bool, NetWorkError>) ->Void
    
    init() {
        
        fetchEntriesFromServer()
    }
    
    
    func sendEntryToServer(entry: Entry, completion: @escaping CompleteHandler = { _ in }) {
        guard let uuid = entry.identifier else {
            completion(.failure(.noIdentifier))
            return
        }
        
        let requestURL = baseURL.appendingPathComponent(uuid.uuidString)
                        .appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        
        do {
            guard let representation = entry.entryRepresentation else {
                completion(.failure(.failedEncode))
                return
            }
            request.httpBody = try JSONEncoder().encode(representation)
        } catch {
            NSLog("Error encoding entry \(entry): \(error)")
            completion(.failure(.failedEncode))
            return
        }
        URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error {
                NSLog("Error sending entry to server \(entry): \(error)")
                completion(.failure(.otherError))
                return
            }
            completion(.success(true))
        }.resume()
    }
    
    
    func deleteEntryFromServer(entry: Entry, completion: @escaping CompleteHandler = { _ in }) {
        guard let uuid = entry.identifier else {
                   completion(.failure(.noIdentifier))
                   return
               }
               
               let requestURL = baseURL.appendingPathComponent(uuid.uuidString)
                               .appendingPathExtension("json")
               var request = URLRequest(url: requestURL)
               request.httpMethod = "DELETE"
               
    
               URLSession.shared.dataTask(with: request) { _, _, error in
                   if let error = error {
                       NSLog("Error sending entry to server \(entry): \(error)")
                       completion(.failure(.otherError))
                       return
                   }
                   completion(.success(true))
               }.resume()
    }
    
    
    func fetchEntriesFromServer(with completion: @escaping CompleteHandler = { _ in }) {
        let requestURL = baseURL.appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                NSLog("Error occured getting request: \(error)")
                completion(.failure(.otherError))
            }
            
            guard let data = data else {
                NSLog("Error occured and go no data back from Firebase")
                completion(.failure(.noData))
                return
            }
            
            do {
                let entriesRepresentations = Array(try JSONDecoder().decode([String : EntryRepresentation].self, from: data).values)
                try self.updateEntries(with: entriesRepresentations)
            } catch {
                NSLog("Error occured decoding data: \(error)")
                completion(.failure(.faliedDecode))
            }
            
            completion(.success(true))
            
        }.resume()
        
    }
   
    
    private func update(entry: Entry, entryRepresentation: EntryRepresentation) {
        entry.title = entryRepresentation.title
        entry.bodyText = entryRepresentation.bodyText
        entry.timestamp = entryRepresentation.timestamp
        entry.mood = entryRepresentation.mood
    }
  
    
    private func updateEntries(with representations: [EntryRepresentation]) throws {
        let identifiersToFetch = representations.compactMap { UUID(uuidString: $0.identifier)}
        let representationsID = Dictionary(uniqueKeysWithValues: zip(identifiersToFetch, representations))
        var entryToCreate = representationsID
        
        let context = CoreDataStack.shared.container.newBackgroundContext()
        
        var error: Error?
        
        context.performAndWait {
            
            let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "identifier IN %@", identifiersToFetch)
            
            do {
                let existing = try context.fetch(fetchRequest)
                
                for entry in existing {
                    guard let id = entry.identifier,
                        let representation = representationsID[id] else { continue }
                    
                    self.update(entry: entry, entryRepresentation: representation)
                    entryToCreate.removeValue(forKey: id)
                }
                
            } catch let fetchError {
                error = fetchError
            }
        
            
            for representation in entryToCreate.values {
                Entry(entryRepresentation: representation, context: context)
            }
        }
        
        if let error = error { throw error}
        try CoreDataStack.shared.save(context: context)
    }
    
}
