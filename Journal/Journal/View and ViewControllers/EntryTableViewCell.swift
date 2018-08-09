//
//  EntryTableViewCell.swift
//  Journal
//
//  Created by Andrew Liao on 8/9/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {
    
    func updateViews(){
        guard let entry = entry  else {return}
        titleLabel.text = entry.title
        dateLabel.text = entry.timeStamp.description
        bodyLabel.text = entry.bodyText
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    var entry: Entry?{
        didSet{
            
                self.updateViews()

            
        }
    }
}
