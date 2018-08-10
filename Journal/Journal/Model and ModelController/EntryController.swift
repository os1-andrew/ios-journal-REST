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
        entries.append(newEntry)
        put(entry: newEntry) { () -> Error? in
            completion()
        }
    }
    
    func update(for entry:Entry, withTitle title: String, bodyText: String, completion: @escaping () -> Error?){
        //find entry in entries and update its properties
        guard let index = entries.index(of: entry) else {return}
        entries[index].title = title
        entries[index].bodyText = bodyText
        
        put(entry: entries[index]) { () -> Error? in
            completion()
        }
    }
    
    //Delete Entry ONLY locally.
    func delete(entry: Entry){
        guard let index = entries.index(of:entry) else { return}
        entries.remove(at: index)
    }
    
    //MARK: - Networking
    func fetchEntries(completion: @escaping (Error?) -> Void){
        let url = baseURL.appendingPathExtension("json")
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog( "Error fetching: \(error)")
                return
            }
            
            guard let data = data else {return}
            let decoder = JSONDecoder()
            
            do{
                let decodedDict = try decoder.decode([String: Entry].self, from: data)
                let decodedEntries = Array(decodedDict.values)
                self.entries = decodedEntries.sorted{ return $0.timeStamp < $1.timeStamp }
                completion(nil)
            } catch {
                NSLog("Error decoding: \(error)")
            }
          
        }.resume()

    }
    
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
        
        //Q: Why do we use this one and not the one without completion handler
        //A: We want to know that the data transfer worked without any errors
        //Sends data out to server

        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let  error = error {
                NSLog("Error with URLSession: \(error)")
                return
            }
            _ = completion()
        }.resume()
        
        
    }
    
    func deleteEntry(entry: Entry, completion: @escaping (Error?) ->Void){
        let url = baseURL
            .appendingPathComponent(entry.identifier)
            .appendingPathExtension("json")
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                NSLog("Error deleting: \(error)")
                return
            }
            self.delete(entry: entry)
            completion(nil)
        }.resume()
    }
}








