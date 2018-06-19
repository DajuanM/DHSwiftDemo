//
//  ViewController.swift
//  DHWebViewJavascriptBridgeDemo
//
//  Created by aiden on 2018/5/22.
//  Copyright © 2018年 aiden. All rights reserved.
//

import UIKit
import WebViewJavascriptBridge

class ViewController: UIViewController, UIWebViewDelegate {

    var webView: UIWebView!
    var bridge: WebViewJavascriptBridge!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
        if bridge != nil {
            return
        }
        webView = UIWebView(frame: view.bounds)
        view.addSubview(webView)

        WebViewJavascriptBridge.enableLogging()
//        bridge = WebViewJavascriptBridge.init(forWebView: webView)
        bridge = WebViewJavascriptBridge(webView)
        bridge.setWebViewDelegate(self)



        bridge.registerHandler("callIdCardIdentify") { (data, responseCallback) in
            self.bridge.callHandler("noImgInJs", data: ["success": "false"])
        }
        bridge.registerHandler("backCardDataInJs") { (data, responseCallback) in
            print("js调用OC")
            self.bridge.callHandler("noImgInJs", data: ["success": "false"])
        }
        
        bridge.registerHandler("testObjcCallback") { (data, responseCallback) in
//            print("js调用OC")
            self.bridge.callHandler("noImgInJs", data: ["success": "false"])
        }


        let path = Bundle.main.path(forResource: "ExampleApp", ofType: "html")
//        let urlStr = "http://www.ccwcar.com/service/survey0/survey.html?token=cbbe6a66f83ea0e839f24f1dfb9cd8d5&comId=8e7635e8d72448ae987c649bdf1830a5"
//        let url = URL.init(string: urlStr)
        let url = URL.init(fileURLWithPath: path!)
        let request = URLRequest(url: url)
        webView.loadRequest(request)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func webViewDidStartLoad(_ webView: UIWebView) {

    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        
    }
}

