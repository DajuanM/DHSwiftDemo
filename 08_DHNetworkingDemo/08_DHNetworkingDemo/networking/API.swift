//
//  API.swift
//  MoyaDemo
//
//  Created by Mustafa on 11/8/17.
//  Copyright © 2017 Mustafa. All rights reserved.
//

import Foundation
import RxSwift
import Moya


var isRefreshingToken = false
var retryCount = 0

struct TokenModel: Codable {
    var access_token: String
    var token_type: String
    var refresh_token: String
}

extension PrimitiveSequence where TraitType == SingleTrait, ElementType == Response {

    public func retryWithAuthIfNeeded(limit: Int) -> Single<E> {
        return self.retryWhen{ errors in
            return errors.enumerated().flatMap{ (retryCount, error) -> Single<TokenModel> in
                

                // 重试超过限制返回错误
                if retryCount >= limit {
                    throw VBError.timeOut
                }
                
                // 重试
                if case MoyaError.statusCode(let response) = error,
                    response.statusCode == 401 {

                    if let json = try JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any] {
                        if let responseErr = json["message"] as? [String: Any],
                            let err = responseErr["error"] as? String,
                            err == "invalid_token" {
                            if !isRefreshingToken {
//                                 jumpToLogin()
                            }
                        }
                    }


                    if isRefreshingToken {
                        return Observable<Int>.interval(RxTimeInterval.init(0.5), scheduler: MainScheduler.instance)
                            .takeWhile({ (_) -> Bool in
                            return !isRefreshingToken
                        }).map({ (_) -> TokenModel in
//                            let model = TokenModel.init(access_token: Util.getAccessToken(), token_type: Util.getTokenType(), refresh_token: Util.getRefreshToken(), tenant: Util.getTenant(), depart: Util.getDepart())
//                            return model
                            return TokenModel(access_token: "", token_type: "", refresh_token: "")
                        }).asSingle()
                    } else {
                        isRefreshingToken = true
                        return
                            Provider.rx
                                .request(VBServiceAPI.refreshToken(refresh_token: ""))//Util.getRefreshToken()
                                .filterSuccessfulStatusCodes()
                                .map(TokenModel.self, atKeyPath: "data", using: JSONDecoder())
                                .catchError({ (error) -> Single<TokenModel> in
                                    //跳转登录
                                    isRefreshingToken = false
                                    throw VBError.refreshTokenError
                                })
                                .flatMap({ (model) -> Single<TokenModel> in
//                                    Util.save(tokenModel: model)
                                    isRefreshingToken = false
                                    return Single.just(model)
                                })
                    }
                }  else {
                    throw VBError.serverDataError
                }
        }
        }
    }
}

private let endpointClosure = { (target: VBServiceAPI) -> Moya.Endpoint<VBServiceAPI> in
    return Endpoint(
        url: "\(URL(target: target).absoluteString)",
        sampleResponseClosure: { .networkResponse(200, target.sampleData) },
        method: target.method,
        task: target.task,
        httpHeaderFields: target.headers)

}

func cancelAllRequest() {
    Provider.manager.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
        dataTasks.forEach { $0.cancel() }
        uploadTasks.forEach { $0.cancel() }
        downloadTasks.forEach { $0.cancel() }
    }
}

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}

let Provider = MoyaProvider<VBServiceAPI>(endpointClosure: NetworkProvider.endpointMapping,
                                          plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])


