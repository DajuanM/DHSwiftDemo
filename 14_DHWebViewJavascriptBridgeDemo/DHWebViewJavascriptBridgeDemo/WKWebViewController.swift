//
//  WKWebViewController.swift
//  DHWebViewJavascriptBridgeDemo
//
//  Created by aiden on 2018/5/22.
//  Copyright © 2018年 aiden. All rights reserved.
//

import UIKit
import WebViewJavascriptBridge
import WebKit

class WKWebViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    var bridge: WebViewJavascriptBridge!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webView = WKWebView(frame: view.bounds)
        webView.navigationDelegate = self
        view.addSubview(webView)

        WebViewJavascriptBridge.enableLogging()
        //        bridge = WebViewJavascriptBridge.init(forWebView: webView)
        bridge = WebViewJavascriptBridge(webView)
        bridge.setWebViewDelegate(self)
        bridge.registerHandler("callIdCardIdentify") { (data, responseCallback) in
            print("js调用OC")
            //backCardDataInJs//noImgInJs
            self.bridge.callHandler("noImgInJs", data: ["success": "false"], responseCallback: { (data) in
                print("OC调用js")
            })
        }

//        bridge.registerHandler("testObjcCallback") { (data, responseCallback) in
//            print("js调用OC")
////            self.bridge.callHandler("testJavascriptHandler", data: ["foo": "before ready"])
//            self.bridge.callHandler("testJavascriptHandler", data: ["foo": "before ready"], responseCallback: { (data) in
//                print("OC调用js")
//            })
//        }

//        let path = Bundle.main.path(forResource: "index", ofType: "html")
        let urlStr = "http://www.ccwcar.com/service/survey0/survey/survey.html?token=cbbe6a66f83ea0e839f24f1dfb9cd8d5&comId=8e7635e8d72448ae987c649bdf1830a5"
        let url = URL.init(string: urlStr)
//        let url = URL.init(fileURLWithPath: path!)
        let request = URLRequest(url: url!)
        webView.load(request)
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {

    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }

}
