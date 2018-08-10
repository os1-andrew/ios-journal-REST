//
//  EntriesTableViewController.swift
//  Journal
//
//  Created by Andrew Liao on 8/9/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import UIKit

class EntriesTableViewController: UITableViewController {

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        entryController.fetchEntries { () -> Error? in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            return nil
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return entryController.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! EntryTableViewCell
        cell.entry = entryController.entries[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let entry = entryController.entries[indexPath.row]
            entryController.deleteEntry(entry: entry ) { (error) in
                if let error = error{
                    NSLog("Error deleting entry: \(error)")
                }
                DispatchQueue.main.async {
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }

            }
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! EntryDetailViewController
        destinationVC.entryController = entryController
        
        if segue.identifier == "ViewEntry" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            destinationVC.entry = entryController.entries[indexPath.row]
            
        }
    }

    
    //MARK - Properties
    
    let entryController = EntryController()

}
