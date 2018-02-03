//
//  ViewController.swift
//  DHArchiveDemo
//
//  Created by aiden on 2018/2/3.
//  Copyright © 2018年 aiden. All rights reserved.
//

import UIKit

let userAccountPath = "\(NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,FileManager.SearchPathDomainMask.userDomainMask,true).first!)/userAccount.data"


class ViewController: UIViewController {
    var userModel = DHUserModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        userModel.name = "aiden"
        userModel.age = 24
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveModel(_ sender: Any) {
        NSKeyedArchiver.archiveRootObject(userModel, toFile:userAccountPath)
    }
    
    @IBAction func getModel(_ sender: Any) {
        if NSKeyedUnarchiver.unarchiveObject(withFile:userAccountPath) != nil {
            let model = (NSKeyedUnarchiver.unarchiveObject(withFile:userAccountPath) as! DHUserModel)
            print("姓名: \(model.name)")
            print("年龄: \(model.age)")
        }
    }
}

