//
//  NormalTableViewCell.swift
//  Reiwashi
//
//  Created by 中嶋裕也 on 2020/02/20.
//  Copyright © 2020 2222_d. All rights reserved.
//

import UIKit

protocol NormalTableViewCellDelegate: class {
    func tappedFabButton()
}

class NormalTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var fabImageView: UIImageView!
    private var delegate: NormalTableViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func fabButton() {
        delegate.tappedFabButton()
    }
    
    func setFab(isFab:Bool) {
        // TODO: 通信処理
        var isisFab = [true,false].randomElement()!
        UIView.transition(with: fabImageView, duration: 0.5, options: [.transitionCrossDissolve], animations: {
            self.fabImageView.image = isisFab ? UIImage.init(systemName: "star") : UIImage.init(systemName: "star.fill")
        })
        
    }
    
}
