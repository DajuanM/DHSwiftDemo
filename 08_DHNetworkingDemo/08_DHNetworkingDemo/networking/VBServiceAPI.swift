//
//  VBServiceAPI.swift
//  VB
//
//  Created by AlienLi on 2017/12/16.
//  Copyright © 2017年 MarcoLi. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON

let apiHelper = NetworkProvider<VBServiceAPI>()

private let info = Bundle.main.infoDictionary
private let appversion = info!["CFBundleShortVersionString"] as! String
private let minor = info!["CFBundleVersion"] as! String

enum VBServiceAPI {
    case getSysMenu
    case refreshToken(refresh_token: String)
}

// MARK: - TargetType Protocol Implementation
extension VBServiceAPI: TargetType {
    var path: String {
        switch self {
        case .getSysMenu:
            return "/ccwadmin/sysMenu/tree/1ec08564dcc344018d6aaa910068f0f0"
        case .refreshToken:
            return ""
        }

    }

    var method: Moya.Method {
        switch self {
        case .getSysMenu:
            return .get
        default:
            return .post
        }
    }

    var parameters: [String : Any] {
        var _params = [String:Any]()
        switch self {
        default:
            break
        }
        return _params
    }

    var task: Task {
        switch self {
        default:
            return Task.requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }

    var sampleData: Data {
        return Data()
    }

    var headers: [String : String]? {
        switch self {
        default:
            return ["Accept": "application/json;charset=UTF-8",
                    "Content-Type": "application/json;charset=utf-8",
                    "usertype": "manager",
                    "device_id": "",
                    "authorization": "Bearer \("")",
                "C-platform":"iOS","C-Version": "\(appversion + minor)"]
        }
    }

    var baseURL: URL {
        switch self {
        default:
            return URL.init(string: "")!
        }
    }
}
// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}


