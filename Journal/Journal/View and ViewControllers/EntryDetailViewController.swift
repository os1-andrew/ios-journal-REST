//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Andrew Liao on 8/9/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {

    @IBAction func save(_ sender: Any) {
    }
    
    @IBOutlet weak var textViewLabel: UITextView!
    @IBOutlet weak var textLabel: UITextField!
    
    var entry: Entry?
    var entryController: EntryController?
}
