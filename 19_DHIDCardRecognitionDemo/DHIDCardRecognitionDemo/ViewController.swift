//
//  ViewController.swift
//  DHIDCardRecognitionDemo
//
//  Created by aiden on 2018/7/8.
//  Copyright © 2018年 aiden. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let button = UIButton(type: .system)
        button.frame = view.bounds
        button.setTitle("点我点我", for: .normal)
        view.addSubview(button)
        button.addTarget(self, action: #selector(taped), for: UIControlEvents.touchUpInside)
    }

    @objc func taped() {
        let IDAuthVC = IDAuthViewController()
        navigationController?.pushViewController(IDAuthVC, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

