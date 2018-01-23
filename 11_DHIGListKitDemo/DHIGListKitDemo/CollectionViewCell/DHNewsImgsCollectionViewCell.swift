//
//  DHNewsImgsCollectionViewCell.swift
//  DHIGListKitDemo
//
//  Created by zipingfang on 2018/1/23.
//  Copyright © 2018年 aiden. All rights reserved.
//

import UIKit

let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height
let window = UIApplication.shared.keyWindow
let ScreenAuto = ScreenWidth / 375.0
let imgSize = CGSize(width: (ScreenWidth-30-8*ScreenAuto*2)/3.0, height: (ScreenWidth-30-8*ScreenAuto*2)/3.0)
let separate = 8 * ScreenAuto

class DHNewsImgsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgContentView: UIView!
    @IBOutlet weak var imgContentViewHeightLC: NSLayoutConstraint!
    var imgArr:[String] = ["1", "2", "3", "4", "5", "1", "2", "3", "4"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        refreshCollectionImgView()
    }
    
//    class func cellSize(_ imgArr: [Any]) -> CGSize {
//        var row: CGFloat = 0
//        if imgArr.count % 3 == 0 {
//            row = CGFloat(imgArr.count / 3)
//        }else {
//            row = CGFloat(imgArr.count / 3 + 1)
//        }
//        print(row * (imgSize.height + (row - 1) * separate))
//        return CGSize(width: ScreenWidth, height: row * (imgSize.height + (row - 1) * separate))
//    }
    
    func refreshCollectionImgView() {
        for sview in imgContentView.subviews {
            sview.removeFromSuperview()
        }
        
        for i in 0..<imgArr.count {
            let imgView = UIImageView(frame: CGRect(x: CGFloat(i%3)*(imgSize.width+separate), y: CGFloat(i/3)*(imgSize.height+separate), width: imgSize.width, height: imgSize.height))
            imgView.backgroundColor = .red
            imgContentView.addSubview(imgView)
            if i == imgArr.count-1 {
                imgContentViewHeightLC.constant = imgView.frame.maxY
            }
        }
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var cellFrame = layoutAttributes.frame
        cellFrame.size.height = size.height
        layoutAttributes.frame = cellFrame
        return layoutAttributes
    }
}
