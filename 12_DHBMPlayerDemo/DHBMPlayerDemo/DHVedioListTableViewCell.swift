//
//  DHVedioListTableViewCell.swift
//  DHBMPlayerDemo
//
//  Created by aiden on 2018/1/19.
//  Copyright © 2018年 com.denghui.demo. All rights reserved.
//

import UIKit

typealias PlayBtnClickedBlock = () -> Void

class DHVedioListTableViewCell: UITableViewCell {
    var playBtnClickedBlock: PlayBtnClickedBlock?
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func playBtnClicked(_ sender: Any) {
        if playBtnClickedBlock != nil {
            self.playBtnClickedBlock!()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
