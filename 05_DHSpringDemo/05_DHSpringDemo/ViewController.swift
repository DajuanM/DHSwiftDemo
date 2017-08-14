//
//  ViewController.swift
//  05_DHSpringDemo
//
//  Created by swartz006 on 2017/8/14.
//  Copyright © 2017年 denghui. All rights reserved.
//

import UIKit
import Spring

class ViewController: UIViewController {
    var bView: SpringView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        bView = SpringView()
        bView.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        bView.backgroundColor = .blue
        view.addSubview(bView)
        
        bView.force = 6
        bView.duration = 10.0
        bView.damping = 0.5
        bView.velocity = 0.6
        bView.scaleX = 2
        bView.scaleY = 2
        bView.rotate = 5
        bView.animation = Spring.AnimationPreset.FadeIn.rawValue
        bView.curve = Spring.AnimationCurve.EaseInOut.rawValue
//        bView.animate()
        bView.animateNext {
            print("动画结束")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

