//
//  ViewController.swift
//  DHCarmeraDemo
//
//  Created by aiden on 2018/8/29.
//  Copyright © 2018年 aiden. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func takePic(_ sender: Any) {
        let cameraVC = CameraViewController()
        present(cameraVC, animated: true, completion: nil)
    }

}

