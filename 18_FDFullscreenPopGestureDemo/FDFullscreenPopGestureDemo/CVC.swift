//
//  CVC.swift
//  FDFullscreenPopGestureDemo
//
//  Created by aiden on 2018/6/26.
//  Copyright © 2018年 aiden. All rights reserved.
//

import UIKit

class CVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "CVC"
        view.backgroundColor = .purple

        let scrollView = DHScrollView(frame: view.bounds)
        scrollView.backgroundColor = .red
        view.addSubview(scrollView)
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.contentSize = CGSize(width: view.bounds.size.width * 2, height: view.bounds.size.height * 2)

        let label = UILabel()
        label.text = "看我看我"
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height)
        scrollView.addSubview(label)

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
