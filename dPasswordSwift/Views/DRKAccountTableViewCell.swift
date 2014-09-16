//
//  DRKAccountTableViewCell.swift
//  dPasswordSwift
//
//  Created by apple on 14-9-16.
//  Copyright (c) 2014年 com.zendai. All rights reserved.
//

import UIKit

class DRKAccountTableViewCell: UITableViewCell {

    @IBOutlet var accountNameLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var passwordLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
