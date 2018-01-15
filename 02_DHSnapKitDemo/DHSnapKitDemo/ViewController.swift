//
//  ViewController.swift
//  DHSnapKitDemo
//
//  Created by swartz006 on 2017/8/9.
//  Copyright © 2017年 denghui. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var view1: UIView!
    var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        button = UIButton(type: .system)
        button.setTitle("点击", for: .normal)
        button.addTarget(self, action: #selector(moveView), for: .touchUpInside)
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 50))
        }
        
        view1 = UIView()
        view1.backgroundColor = UIColor.red
        view.addSubview(view1)
        view1.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(200)
            make.centerX.equalTo(view)
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func moveView() {
        let top = view1.frame.origin.y == 100 ? 200 : 100
        view1.snp.updateConstraints { (make) in
            make.top.equalToSuperview().offset(top)
        }
        UIView.animate(withDuration: 1, animations: { 
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

}

