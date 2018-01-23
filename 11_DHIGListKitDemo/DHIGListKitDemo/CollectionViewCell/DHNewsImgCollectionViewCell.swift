//
//  DHNewsImgCollectionViewCell.swift
//  DHIGListKitDemo
//
//  Created by zipingfang on 2018/1/23.
//  Copyright © 2018年 aiden. All rights reserved.
//

import UIKit

class DHNewsImgCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgView.backgroundColor = .red
    }

}
