//
//  NetworProvider.swift
//  Collector
//
//  Created by listen on 2017/12/8.
//  Copyright © 2017年 covermedia. All rights reserved.
//

import UIKit
import Moya
import RxSwift

class NetworkProvider<Target: TargetType>{
    private let provider: MoyaProvider<Target>

    init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = NetworkProvider.endpointMapping,
         requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider.defaultRequestMapping,
         stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider.neverStub,
         manager: Manager = NetworkProvider.sessionManager(),
         plugins: [PluginType] = [NetworkLogger()],
         trackInflights: Bool = false) {
        self.provider = MoyaProvider(endpointClosure: endpointClosure,
                                     requestClosure: requestClosure,
                                     stubClosure: stubClosure,
                                     manager: manager,
                                     plugins: plugins,
                                     trackInflights: trackInflights)
    }

    
    func request(_ target: Target) -> Observable<Moya.Response> {
        return provider.rx
            .request(target)
            .filterSuccessfulStatusAndRedirectCodes()
            .retryWithAuthIfNeeded(limit: 5)
            .asObservable()
    }

}



struct NetModel: Decodable {
//    let message: String
    let status: Int
    var isSucceed: Bool {
        return 200 == status
    }
}
struct InvalidToken: Codable {
    let error_description: String
    let error: String?
}

public extension ObservableType where E == Response {

    //data字段为空（或者值没有意义）时，使用 MapVoid()
    public func mapVoid() -> Observable<Void> {
        return mapToModel(NetModel.self, keyPath: "").map { _ in Void() }
    }
    public func mapToModel<T: Decodable>(_: T.Type, decoder:JSONDecoder = JSONDecoder.init(), keyPath:String = "data") -> Observable<T> {
        
        return map({ (response) -> T in
//            response.statusCode != 200 {
//                throw VBError.server(response.response.)
//            }
            let object = try Network.decodableObject(data: response.data, type: T.self, decoder: decoder, keyPath: keyPath)
            return object
        }).catchError { (err) -> Observable<T> in
            
            // 捕获错误，转换为VBError
            return Observable<T>.create({ (observe) -> Disposable in
                var finalError = VBError.dataMapError(err.localizedDescription)
                if let error = err as? MoyaError, let reponse = error.response {
                    if reponse.statusCode == NSURLErrorTimedOut {
                        finalError = VBError.timeOut
                    }
                } else if let error = err as? VBError {
                    finalError = error
                }
                observe.onError(finalError)
                return Disposables.create()
            })}
    }

    public func mapToArrayModel<T: Decodable>(_: T.Type, decoder:JSONDecoder = JSONDecoder.init(), keyPath: String? = "data") -> Observable<[T]> {
        
        return map({ (response) -> [T] in
            let object = try Network.decodableArrayObject(data: response.data, type: T.self, decoder: decoder, keyPath: keyPath)
            return object
        }).catchError { (err) -> Observable<[T]> in
            // 捕获错误，转换为VBError
            return Observable<[T]>.create({ (observe) -> Disposable in
                var finalError = VBError.dataMapError(err.localizedDescription)
                if let error = err as? MoyaError, let reponse = error.response {
                    if reponse.statusCode == NSURLErrorTimedOut {
                        finalError = VBError.timeOut
                    }
                } else if let error = err as? VBError {
                    finalError = error
                }
                observe.onError(finalError)
                return Disposables.create()
            })}
    }
    
    
}


