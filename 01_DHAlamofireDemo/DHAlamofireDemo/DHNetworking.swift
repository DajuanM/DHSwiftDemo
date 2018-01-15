//
//  DHNetworking.swift
//  DHAlamofireDemo
//
//  Created by swartz006 on 2017/8/8.
//  Copyright © 2017年 denghui. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DHNetworking: NSObject {
    override init() {
        
    }
    
    func request(url: String, method: HTTPMethod, param: Dictionary<String, Any>, success: @escaping (_ response: Any) -> (), fail: @escaping (_ error: Error) -> ()){
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        Alamofire.request(url, method: method, parameters: param, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                print("\(value)")
                success(value)
            case .failure(let error):
                print("\(error.localizedDescription)")
                fail(error)
            }
        }
    }
}



