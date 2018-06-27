//
//  BVC.swift
//  FDFullscreenPopGestureDemo
//
//  Created by aiden on 2018/6/26.
//  Copyright © 2018年 aiden. All rights reserved.
//

import UIKit
import FDFullscreenPopGesture

class BVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "BVC"
        view.backgroundColor = .green
        
        let btn = UIButton(frame: CGRect(x: 100, y: 200, width: 100, height: 100))
        btn.setTitle("Push", for: .normal)
        btn.addTarget(self, action: #selector(pushVC), for: UIControlEvents.touchUpInside)
        view.addSubview(btn)
    }

    @objc func pushVC() {
        navigationController?.pushViewController(CVC(), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
