//
//  NetWorkProvider+Defaults.swift
//  Collector
//
//  Created by listen on 2017/12/8.
//  Copyright © 2017年 covermedia. All rights reserved.
//

import UIKit
import Alamofire
import Moya

extension NetworkProvider {

    static func endpointMapping(_ target: Target) -> Endpoint<Target> {
        var urlString = URL.init(target: target).absoluteString

        urlString = urlString.replacingOccurrences(of: "%3F", with: "?")

//        if urlString.contains("/managers/resetPwd")  {
//            let list = urlString.components(separatedBy: "%3F")
//            if let first = list.first, let last = list.last {
//                urlString = first + "?" + last
//            }
//        }

        
        return Endpoint(
            url: urlString,
            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
        )
    }
    
    static func sessionManager() -> Manager {
        let configuration = URLSessionConfiguration.default
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            globalAPIEnvironment.rawValue: .pinCertificates(certificates: ServerTrustPolicy.certificates(),validateCertificateChain:true, validateHost:false)
        ]
        let sessionDelegate = SessionDelegate()
        let  _manager = SessionManager.init(configuration: configuration, delegate: sessionDelegate, serverTrustPolicyManager: ServerTrustPolicyManager.init(policies: serverTrustPolicies))
        sessionDelegate.sessionDidReceiveChallenge = { session, challenge in
            var disposition: URLSession.AuthChallengeDisposition = .performDefaultHandling
            var credential: URLCredential?
            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
                disposition = URLSession.AuthChallengeDisposition.useCredential
                credential = URLCredential.init(trust: challenge.protectionSpace.serverTrust!)
            } else {
                if challenge.previousFailureCount > 0 {
                    disposition = .cancelAuthenticationChallenge
                } else {
                    if let cr = _manager.session.configuration.urlCredentialStorage?.defaultCredential(for: challenge.protectionSpace) {
                        disposition = .useCredential
                        credential = cr
                    }
                }
            }
            return (disposition, credential)
        }
        return _manager
    }

    
}
