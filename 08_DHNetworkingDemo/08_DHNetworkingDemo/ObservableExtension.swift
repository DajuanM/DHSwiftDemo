//
//  ObservableExtension.swift
//  08_DHNetworkingDemo
//
//  Created by zipingfang on 2017/12/27.
//  Copyright © 2017年 com.denghui.demo. All rights reserved.
//

import Foundation
import RxSwift
import HandyJSON
import Moya
import SwiftyJSON

enum DHError: Swift.Error {
    case ParaseJSONError
    case RequestFail
    case NoResponse
    case UnexpectedResult(resultCode: Int?, resultMsg: String?)
}

public extension Observable {
    func mapResponseToObject<T: HandyJSON>(type: T.Type) -> Observable<T> {
        return map { response in
            //检测返回值
            guard let response = response as? Moya.Response else {
                throw DHError.NoResponse
            }
            //检测状态码
            guard ((200...209) ~= response.statusCode) else {
                throw DHError.RequestFail
            }
            //检测返回数据格式
            guard let dict = JSON(response.data).dictionaryObject else {
                throw DHError.ParaseJSONError
            }
            return JSONDeserializer<T>.deserializeFrom(dict: dict)!
        }
    }
    
    func mapResponseToArray<T: HandyJSON>(type: T.Type) -> Observable<T> {
        return map { response in
            //检测返回值
            guard let response = response as? Moya.Response else {
                throw DHError.NoResponse
            }
            //检测状态码
            guard ((200...209) ~= response.statusCode) else {
                throw DHError.RequestFail
            }
            //检测返回数据格式
            guard let array = JSON(response.data).arrayObject else {
                throw DHError.ParaseJSONError
            }
            return JSONDeserializer<T>.deserializeModelArrayFrom(array: array) as! T
        }
    }
}
