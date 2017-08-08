//
//  ViewController.swift
//  DHAlamofireDemo
//
//  Created by swartz006 on 2017/8/8.
//  Copyright © 2017年 denghui. All rights reserved.
//

import UIKit
import ObjectMapper
import SwiftyJSON

let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height

class ViewController: UIViewController {
    
    let tableView: UITableView =  {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    var dataArr: Array<DHModel> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        DHNetworking().request(url: "http://qf.56.com/pay/v4/giftList.ios", method: .get, param: [:], success: { (response) in
            let json = JSON(response)
            self.dataArr = Mapper<DHModel>().mapArray(JSONArray: (json["message"]["list"].arrayObject as? [[String: Any]])!)
            self.tableView.reloadData()
        }) { (error) in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let model = dataArr[indexPath.row]
        cell.textLabel?.text = model.authInfo
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

