//
//  WebViewController.swift
//  07_DHWKWebViewDemo
//
//  Created by mac on 2019/6/18.
//  Copyright © 2019 aiden. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    let webView = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webView.frame = view.bounds
        let path = Bundle.main.path(forResource: "index", ofType: "html")
        let request = URLRequest(url: URL(fileURLWithPath: path!))
        webView.loadRequest(request)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
