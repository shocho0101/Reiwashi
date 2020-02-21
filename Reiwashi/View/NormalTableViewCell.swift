//
//  NormalTableViewCell.swift
//  Reiwashi
//
//  Created by 中嶋裕也 on 2020/02/20.
//  Copyright © 2020 2222_d. All rights reserved.
//

import UIKit

class NormalTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
