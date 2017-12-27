//
//  ApiManager.swift
//  08_DHNetworkingDemo
//
//  Created by zipingfang on 2017/12/27.
//  Copyright © 2017年 com.denghui.demo. All rights reserved.
//

import Foundation
import Moya

enum APIManager {
    case GetNewsList
    case GetNewsDetail(Int)
}

extension APIManager: TargetType {
    var headers: [String : String]? {
        return [:]
    }
    
    /// The target's base `URL`.
    var baseURL: URL {
        return URL.init(string: "http://news-at.zhihu.com/api/")!
    }
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case .GetNewsList: // 不带参数的请求
            return "4/news/latest"
        case .GetNewsDetail(let id):  // 带参数的请求
            return "4/theme/\(id)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    /// The parameters to be incoded in the request.
    var parameters: [String: Any]? {
        return nil
    }
    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    /// Provides stub data for use in testing.
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    /// The type of HTTP task to be performed.
    var task: Task {
        return .requestPlain
    }
    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    var validate: Bool {
        return false
    }
}


