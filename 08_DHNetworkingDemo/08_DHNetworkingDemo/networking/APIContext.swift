//
//  APIContext.swift
//  Collector
//
//  Created by listen on 2017/12/8.
//  Copyright © 2017年 covermedia. All rights reserved.
//

import UIKit


var globalAPIEnvironment: APIEnvironment = {
    if let api = UserDefaults.standard.object(forKey: "globalAPIEnvironment") as? String {
        return APIEnvironment.init(rawValue: api)!
    } else {
        return APIEnvironment.release
    }
}()


let logNetwork = true

enum APIEnvironment: String {
//    case debug = "http://ccwcar.iask.in:8070"
    case debug = "http://biz.ccwcar.com:8765/api"
    case release = "http://api.ccwcar.com"
    case carBrand = "http://125.65.82.194:8080/carCommon"
    
    case debug_mall = "http://ccwcar.iask.in:808/mall/"
    case release_mall = "http://www.ccwcar.com/mall/"
    
   
    
}

