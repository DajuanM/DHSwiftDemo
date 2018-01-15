//
//  DHTabBarController.swift
//  10_DHTabBarDemo
//
//  Created by zipingfang on 2018/1/9.
//  Copyright © 2018年 com.denghui.demo. All rights reserved.
//

import UIKit

class DHTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let AVC = DHAViewController()
        AVC.tabBarItem = createItem("A")
        addChildViewController(AVC)
        
        let BVC = DHBViewController()
        BVC.tabBarItem = createItem("B")
        addChildViewController(BVC)
        
        let label = UILabel(frame: CGRect(x: 20, y: 15, width: 100, height: 20))
        label.text = "123"
        tabBar.addSubview(label)
    }
    
    func createItem(_ title: String) -> UITabBarItem {
        let tabBarItem = UITabBarItem(title: title, image: nil, selectedImage: nil)
        return tabBarItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
