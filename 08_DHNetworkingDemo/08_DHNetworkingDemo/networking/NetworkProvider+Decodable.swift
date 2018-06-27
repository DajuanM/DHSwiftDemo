//
//  NetworkProvider+Decodable.swift
//  Collector
//
//  Created by listen on 2017/12/11.
//  Copyright © 2017年 covermedia. All rights reserved.
//

import Foundation

struct Network {

    static func decodableObject<T:Decodable>(data: Data, type: T.Type, decoder:JSONDecoder = JSONDecoder.init(), keyPath:String = "data") throws -> T {
        
            let json = try JSONSerialization.jsonObject(with: data,
                                                        options: .allowFragments)
        if keyPath == "" {
            if (!JSONSerialization.isValidJSONObject(json)) {
                throw VBError.serverDataError
            }
            let nestedData = try JSONSerialization.data(withJSONObject: json)
            let nestedObj = try decoder.decode(T.self, from: nestedData)
            return nestedObj
        }else {
            let object = try decoder.decode(NetModel.self, from: data)
            if object.isSucceed {
                if let nestedJson = keyPath.isEmpty ? json : (json as AnyObject).value(forKeyPath: keyPath) {
                    if (!JSONSerialization.isValidJSONObject(nestedJson)) {
                        throw VBError.serverDataError
                    }
                    let nestedData = try JSONSerialization.data(withJSONObject: nestedJson)
                    let nestedObj = try decoder.decode(T.self, from: nestedData)
                    return nestedObj
                } else {
//                    throw VBError.server(object.status,object.message)
                    throw VBError.serverDataError
                }
            }
//            throw VBError.server(object.status,object.message)
            throw VBError.serverDataError
        }
    }
    
    static func decodableArrayObject<T:Decodable>(data:Data, type: T.Type,decoder:JSONDecoder = JSONDecoder.init(), keyPath: String? = "data") throws -> [T] {

        if keyPath == nil {
            // 适用于通用数据类型
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            if let nestedJsons = (json as AnyObject) as? NSArray {
                var nestedObjs:[T] = []
                for nestedJson in nestedJsons {
                    let nestedData = try JSONSerialization.data(withJSONObject: nestedJson)
                    let nestedObj = try decoder.decode(T.self, from: nestedData)
                    nestedObjs.append(nestedObj)
                }
                return nestedObjs
            } else {
                throw VBError.serverDataError
            }
        } else {
            // 适用于 含有 {status: 200, message:"",data: [xxx,xxx]}
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            let object = try decoder.decode(NetModel.self, from: data)
            if object.isSucceed {
                if let nestedJsons = ((json as Any) as AnyObject).value(forKeyPath: keyPath!) as? NSArray {
                    var nestedObjs:[T] = []
                    for nestedJson in nestedJsons {
                        let nestedData = try JSONSerialization.data(withJSONObject: nestedJson)
                        let nestedObj = try decoder.decode(T.self, from: nestedData)
                        nestedObjs.append(nestedObj)
                    }
                    return nestedObjs
                } else {
                    throw VBError.serverDataError
                }
            } else {
//                throw VBError.server(object.code,object.message)
                throw VBError.serverDataError
            }
        }
    }

}
