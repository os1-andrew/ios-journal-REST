//
//  Entry.swift
//  Journal
//
//  Created by Andrew Liao on 8/9/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import Foundation

struct Entry: Equatable, Codable {
    let title:String
    var bodyText: String
    let timeStamp: Date
    let identifier: String
    
    init(title: String, bodyText: String, timeStamp:Date = Date(), identifier: String = UUID().uuidString) {
        self.title = title
        self.bodyText = bodyText
        self.timeStamp = timeStamp
        self.identifier = identifier
    }

    //TODO: Might need to implement == function
}
