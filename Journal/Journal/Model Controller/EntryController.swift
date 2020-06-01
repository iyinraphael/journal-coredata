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
    
}
