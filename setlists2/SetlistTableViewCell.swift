//
//  SetlistTableViewCell.swift
//  setlists2
//
//  Created by Chris McQueen on 7/26/18.
//  Copyright © 2018 Chris McQueen. All rights reserved.
//

import UIKit

class SetlistTableViewCell: UITableViewCell {
    
    @IBOutlet weak var setlistLabel: UILabel!
    @IBOutlet weak var songKey: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
