//
//  ViewController.swift
//  07_DHWKWebViewDemo
//
//  Created by aiden on 2017/8/16.
//  Copyright © 2017年 aiden. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    var webView: WKWebView!
    var userControler: WKUserContentController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        userControler = WKUserContentController()
        
        
        let config = WKWebViewConfiguration()
        config.userContentController = userControler
        //偏好设置
        config.preferences = WKPreferences()
        //字体
        config.preferences.minimumFontSize = 30
        //设置js跳转
        config.preferences.javaScriptEnabled = true
        //不自动打开窗口
        config.preferences.javaScriptCanOpenWindowsAutomatically = false
        //web内容处理池
        config.processPool = WKProcessPool()
        
        webView = WKWebView(frame: view.bounds, configuration: config)
        webView.navigationDelegate = self
        view.addSubview(webView)
        let path = Bundle.main.path(forResource: "index", ofType: "html")
        let request = URLRequest(url: URL(fileURLWithPath: path!))
        webView.load(request as URLRequest)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userControler.add(self as WKScriptMessageHandler, name: "callOC")
        userControler.add(self as WKScriptMessageHandler, name: "callJS")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        userControler.removeAllUserScripts()
    }
    // JS调用OC
    func callOC() {
        let alertVC = UIAlertController(title: "JS调用OC", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    // OC调用JS
    func callJS() {
        webView.evaluateJavaScript("showText()") { (response, error) in
        
        }
    }
}

extension ViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "callOC"  {
            callOC()
        }
        if message.name == "callJS" {
            callJS()
        }
    }
}

extension ViewController: WKNavigationDelegate {
    //页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    //开始返回内容时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    //页面加载完成时调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    //页面加载失败时调用
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
    }
    //接收到服务器跳转请求时调用
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        
    }
}


