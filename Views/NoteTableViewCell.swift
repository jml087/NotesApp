//
//  NoteTableViewCell.swift
//  Notes App
//
//  Created by Julia Molian Li on 11/16/18.
//  Copyright © 2018 Julia Molian Li. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    var title : String = ""
    var note : NewNote?
    @IBOutlet var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
