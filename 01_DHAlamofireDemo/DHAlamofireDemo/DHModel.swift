//
//  DHModel.swift
//  DHAlamofireDemo
//
//  Created by swartz006 on 2017/8/8.
//  Copyright © 2017年 denghui. All rights reserved.
//

import ObjectMapper

class DHModel: Mappable {
    var auth: String?
    var authInfo: String?
    var img: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        auth <- map["auth"]
        authInfo <- map["authInfo"]
        img <- map["img"]
    }
}
