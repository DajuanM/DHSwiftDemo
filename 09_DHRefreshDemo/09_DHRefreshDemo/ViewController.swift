//
//  ViewController.swift
//  09_DHRefreshDemo
//
//  Created by zipingfang on 2017/12/27.
//  Copyright © 2017年 com.denghui.demo. All rights reserved.
//

import UIKit
import MJRefresh

class ViewController: UIViewController {
    let tableView: UITableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.frame = view.bounds
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(self.refreshHeader))
//        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                self.tableView.mj_header.endRefreshing()
//            }
//        })
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(self.refreshFooter))
//        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                self.tableView.mj_footer.endRefreshing()
//            }
//        })
        view.addSubview(tableView)
    }
    
    @objc func refreshHeader() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.tableView.mj_header.endRefreshing()
        }
    }
    
    @objc func refreshFooter() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.tableView.mj_footer.endRefreshing()
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "第\(indexPath.row)行"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 60
    }
}

