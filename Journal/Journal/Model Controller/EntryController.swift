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
    
    let baseURL = URL(string: "https://iossprint4project.firebaseio.com/")!
    
    typealias CompleteHandler = (Result<Bool, NetWorkError>) ->Void
    
    init() {
        
    }
    
}
