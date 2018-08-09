//
//  EntryController.swift
//  Journal
//
//  Created by Andrew Liao on 8/9/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import Foundation

private let baseURL = URL(string: "https://journal-78b1d.firebaseio.com/")!

class EntryController {
    var entries = [Entry]()
    
    
    //MARK: - CRUD
    func createEntry(withTitle title: String, bodyText:String, completion: @escaping () ->Error?){
        let newEntry = Entry(title: title, bodyText: bodyText)
        put(entry: newEntry) { () -> Error? in
            completion()
        }
    }
    
    
    //MARK: - Networking
    
    func put(entry: Entry, completion: @escaping () -> Error?){
        
        //builds URL for each Entry
        let url = baseURL
            .appendingPathComponent(entry.identifier)
            .appendingPathExtension("json")
        
        //FIX: Is there a default httpMethod for initialized request
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        //encodes entry to JSON, attach data to request in the HTTP Body to send to the server
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(entry)
            request.httpBody = data
        } catch {
            NSLog("Error encoding")
            return
        }
        
        //FIX: Why do we use this one and not the one without completion handler
        //Sends data out to server
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let  error = error {
                NSLog("Error with URLSession: \(error)")
                return
            }
            _ = completion()
        }.resume()
        
        
    }
}
