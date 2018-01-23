//
//  DHNewsTopCollectionViewCell.swift
//  DHIGListKitDemo
//
//  Created by zipingfang on 2018/1/23.
//  Copyright © 2018年 aiden. All rights reserved.
//

import UIKit

class DHNewsTopCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avatar.layer.cornerRadius = avatar.bounds.width/2.0
        avatar.layer.masksToBounds = true
        avatar.backgroundColor = .red
    }
}
