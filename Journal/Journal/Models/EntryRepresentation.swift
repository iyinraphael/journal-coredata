//
//  EntryRepresentation.swift
//  Journal
//
//  Created by Iyin Raphael on 6/1/20.
//  Copyright © 2020 Iyin Raphael. All rights reserved.
//

import Foundation

struct EntryRepresentation: Codable {
    let title: String
    let bodyText: String?
    let timestamp: Date
    let identifier: String
    let mood: Mood.RawValue
    
}
