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
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var fabCountLabel: UILabel!
    
    private var delegate: NormalTableViewCellDelegate!
    var word: Word!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func config() {
        nameLabel.text = word.name
        fabCountLabel.text = word.fabCount.description
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM", options: 0, locale: Locale(identifier: "ja_JP"))
        dateLabel.text = formatter.string(from: Date())
    }
    
    @IBAction func fabButton() {
        delegate.tappedFabButton()
    }
    
    func setFab() {
        if word.isFab {
            word.fabCount -= 1
        } else {
            word.fabCount += 1
        }
        UIView.transition(with: fabImageView, duration: 0.5, options: [.transitionCrossDissolve], animations: {
            self.fabImageView.image = self.word.isFab ? UIImage.init(systemName: "star") : UIImage.init(systemName: "star.fill")
        })
        word.isFab.toggle()
        config()
    }
    
}
