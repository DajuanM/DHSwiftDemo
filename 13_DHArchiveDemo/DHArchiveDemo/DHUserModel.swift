//
//  DHModel.swift
//  DHArchiveDemo
//
//  Created by aiden on 2018/2/3.
//  Copyright © 2018年 aiden. All rights reserved.
//

import UIKit

class DHUserModel: NSObject, NSCoding {
    
    var name = ""
    var age = 0

    override init() {
        super.init()
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.age, forKey: "age")
    }

    required init?(coder aDecoder: NSCoder) {
        super.init()
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        //基础数据类型不可以使用此函数，不然获取不到数据
//        self.age = aDecoder.decodeObject(forKey: "age") as! Int
        self.age = aDecoder.decodeInteger(forKey: "age")
    }
}
