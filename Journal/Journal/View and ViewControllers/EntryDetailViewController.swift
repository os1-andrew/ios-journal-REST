//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Andrew Liao on 8/9/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {

    func updateViews(){
        if !isViewLoaded { return }
        
        switch entry {
        case nil:
            self.title = "Create Entry"
        default:
            self.title = entry?.title
            textLabel.text = entry?.title
            textViewLabel.text = entry?.bodyText
        }

        
    }
    
    
    @IBAction func save(_ sender: Any) {
        guard let title = textLabel.text,
            let bodyText = textViewLabel.text else {return}
        
        if title == "" || bodyText == "" {return}
        
        if let entry = entry {
            entryController?.update(for: entry, withTitle: title, bodyText: bodyText) {
                self.navigationController?.popViewController(animated: true)
                return nil }
        } else {
            entryController?.createEntry(withTitle: title, bodyText: bodyText){
                self.navigationController?.popViewController(animated: true)
                return nil}
        }
        
        
        
    }
    
    @IBOutlet weak var textViewLabel: UITextView!
    @IBOutlet weak var textLabel: UITextField!
    
    var entryController: EntryController?
    var entry: Entry?{
        didSet{
            updateViews()
        }
    }
}
