//
//  ViewController.swift
//  DHYNDropDownMenuDemo
//
//  Created by aiden on 2018/5/23.
//  Copyright © 2018年 aiden. All rights reserved.
//

import UIKit
import YNDropDownMenu

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the dropView, typically from a nib.
        view.backgroundColor = .white
        
        let view1 = DHView1(titles: ["1", "2", "3", "4", "5", "6"])
        let view2 = DHView1(titles: ["1", "2", "3"])
        let dropView = YNDropDownMenu(frame: CGRect(x: 0, y: 64, width: UIScreen.main.bounds.size.width, height: 38), dropDownViews: [view1, view2], dropDownViewTitles: ["Apple", "banana"])

        dropView.setImageWhen(normal: UIImage(named: "arrow_nor"), selected: UIImage(named: "arrow_sel"), disabled: UIImage(named: "arrow_dim"))

        dropView.setLabelColorWhen(normal: .black, selected: .red, disabled: .gray)

        dropView.setLabel(font: .systemFont(ofSize: 12))

        dropView.backgroundBlurEnabled = true
        dropView.bottomLine.isHidden = false
        // Add custom blurEffectView
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        dropView.blurEffectView = backgroundView
        dropView.blurEffectViewAlpha = 0.3

        dropView.setBackgroundColor(color: UIColor.white)

        view.addSubview(dropView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

