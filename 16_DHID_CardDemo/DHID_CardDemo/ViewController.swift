//
//  ViewController.swift
//  DHID_CardDemo
//
//  Created by aiden on 2018/5/11.
//  Copyright © 2018年 aiden. All rights reserved.
//

import UIKit
import Alamofire

let APP_KEY = "24886611"
let APP_SECRET = "5a52005855f62e6e8f2138a745a797c1"
let APP_CODE = "2ceb76d3410d4e678faacd9d6d177887"//"04cf8ab564744e6fb7e7187a485321c5"//

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let image = UIImage(named: "id_card")
        let data = UIImageJPEGRepresentation(image!, 1.0)
        let imageStr = data?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        let dataStr = "{\"inputs\":[{\"image\":{\"dataType\":50,\"dataValue\":\"\(imageStr ?? "")\"},\"configure\":{\"dataType\":50,\"dataValue\":\"{\\\"side\\\":\\\"face\\\"}\"}}]}"
        let client = BaseApiClient(key: APP_KEY, appSecret: APP_SECRET)
        client?.httpPost(CLOUDAPI_HTTPS, host: "dm-51.data.aliyun.com", path: "/rest/160601/ocr/ocr_idcard.json", pathParams: [:], queryParams: [:], body: dataStr.data(using: .utf8), headerParams: [:], completionBlock: { (data, response, error) in
            if (error != nil) {
                print(error?.localizedDescription as Any)
            }else {
                print(String.init(data: data!, encoding: String.Encoding.utf8)!)
            }
        })
        client?.verifyCert = { (code) in
            return true
        }


//        let body = "{\"image\":\"\(imageStr)\",\"configure\":\"{\\\"side\\\":\\\"face\\\"}\"}"
//        var request = URLRequest(url: URL(string: "https://dm-51.data.aliyun.com/rest/160601/ocr/ocr_idcard.json")!, cachePolicy: NSURLRequest.CachePolicy.init(rawValue: 1)!, timeoutInterval: 5)
//        request.httpMethod = "POST"
//        request.addValue("APPCODE \(APP_CODE)", forHTTPHeaderField: "APPCODE")
//        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
//        let bodyData = body.data(using: String.Encoding.utf8)
//        request.httpBody = bodyData
//        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
//        let task = urlSession.dataTask(with: request) { (data, response, url) in
//            print(data)
//        }
//        task.resume()
//        let ulrStr = "https://dm-51.data.aliyun.com/rest/160601/ocr/ocr_idcard.json"
//        let param = ["image": imageStr ?? "", "configure": "{\"side\":\"face\"}"]
//        let headers = ["Authorization": APP_CODE, "Content-Type": "application/json; charset=UTF-8"]

//        Alamofire.request(ulrStr, method: HTTPMethod.post, parameters: param,  encoding: URLEncoding.default, headers: headers)
////            .validate(contentType: ["application/json; charset=UTF-8"])
////            .responseData { (resonse) in
////                switch resonse.result {
////                case .success(let value):
////                    let data = value
////                    print(data)
////                    do{
////                        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
////
////                        let dic = json as! Dictionary<String, Any>
////                        print(dic)
////                    }catch {
////                        print("失败")
////                    }
////                case .failure(let error):
////                    print(error.localizedDescription)
////                }
////        }
//            .responseJSON { (response) in
//            switch response.result {
//            case .success(let value):
//                let dict = value as! [String: Any]
//                print(dict)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func test2() {
        let image = UIImage(named: "id_card")
        let data = UIImageJPEGRepresentation(image!, 1.0)
        let imageStr = data?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        let ulrStr = "https://dm-51.data.aliyun.com/rest/160601/ocr/ocr_idcard.json"
        let param = ["image": imageStr ?? "", "configure": "{\"side\":\"face\"}"]
//        let headers = ["Authorization": APP_CODE, "Content-Type": "application/json; charset=UTF-8"]
        var headers: [[String: Any]] = []

        let date = Date()
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US")
        df.dateFormat = "EEE, dd MMM yyyy HH:mm:ss"
        headers.append(["Date": df.string(from: date)])

        let timeStamp = Date().timeIntervalSince1970 * 1000
        headers.append(["X-Ca-Timestamp": String.init(format: "%0.0lf", timeStamp)])

        headers.append(["User-Agent": "ALIYUN-OBJECTC-DEM"])
        headers.append(["Host": "dm-51.data.aliyun.com"])
        headers.append(["X-Ca-Key": APP_KEY])
        headers.append(["X-Ca-Version": "1"])
        headers.append(["Content-Type": ""])
        headers.append(["Accept": ""])

    }
}

