//
//  DHNewsBottomCollectionViewCell.swift
//  DHIGListKitDemo
//
//  Created by zipingfang on 2018/1/23.
//  Copyright © 2018年 aiden. All rights reserved.
//

import UIKit
import SnapKit

class DHNewsBottomCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.snp.makeConstraints { (make) in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.top.left.right.bottom.equalToSuperview()
        }
    }

}
