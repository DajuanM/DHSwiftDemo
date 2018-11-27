//
//  BaseTableViewController.swift
//  DHPersonalDemo
//
//  Created by mac on 2018/9/11.
//  Copyright © 2018年 aiden. All rights reserved.
//

import UIKit

class BaseTableViewController: UIViewController, UIScrollViewDelegate {
    
    let tableView = UITableView()
    var canScroll = false 
    var isTouch = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self as? UITableViewDataSource
        tableView.delegate = self as? UITableViewDelegate
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        canScroll = false
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isTouch = true
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        isTouch = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !canScroll {
            scrollView.setContentOffset(.zero, animated: false)
        }
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            if !isTouch {
                return
            }
            NotificationCenter.default.post(name: NSNotification.Name.init("LeaveTop"), object: nil)
            canScroll = false
            scrollView.setContentOffset(.zero, animated: false)
        }
    }
}
