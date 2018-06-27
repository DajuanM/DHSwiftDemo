//
//  VBError.swift
//  VB
//
//  Created by AlienLi on 2018/2/10.
//  Copyright © 2018年 MarcoLi. All rights reserved.
//

import UIKit

enum VBError {
    case timeOut
    case serverDataError
    case dataMapError(String)
    case server(Int, String)
    case tokenInvalid
    case refreshTokenError
}

extension VBError: Error {}


extension VBError {
    var errorMessage:String {
        switch self {
        case .timeOut:
            return "网络超时，请重新尝试"
        case .serverDataError:
            return "服务器返回数据错误"
        case .server(_, let msg):
            return msg
        case .tokenInvalid:
            return "会话过期"
        case .dataMapError:
            return "数据解析出错"
        case .refreshTokenError:
            return "登录信息过期,请重新登录"
        }
    }
}
