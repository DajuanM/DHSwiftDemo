//
//  ViewController.swift
//  FDFullscreenPopGestureDemo
//
//  Created by aiden on 2018/6/26.
//  Copyright © 2018年 aiden. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "Main"
        view.backgroundColor = .blue
        navigationController?.navigationBar.isTranslucent = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pushBtnClicked(_ sender: Any) {
        navigationController?.pushViewController(AVC(), animated: true)
    }


}

