//
//  ViewController.swift
//  DHPersonalDemo
//
//  Created by mac on 2018/9/11.
//  Copyright © 2018年 aiden. All rights reserved.
//

import UIKit

let headerHeight: CGFloat = 200.0
let segementHeight: CGFloat = 50.0

//class ViewController: UIViewController {
//
//    var canScroll = false
//    let mainScrollView = UIScrollView()
//    let contentScrollView = UIScrollView()
//    let segementView = UIView()
//    let topView = TopView()
//    let leftVC = LeftViewController()
//    let rightVC = RightViewController()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.addSubview(mainScrollView)
//        topView.backgroundColor = .red
//        mainScrollView.addSubview(topView)
//        segementView.backgroundColor = .blue
//        mainScrollView.addSubview(segementView)
//        mainScrollView.addSubview(contentScrollView)
//        contentScrollView.addSubview(leftVC.view)
//        contentScrollView.addSubview(rightVC.view)
//        addChildViewController(leftVC)
//        addChildViewController(rightVC)
//
//        mainScrollView.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
//        }
//        topView.snp.makeConstraints { (make) in
//            make.top.left.right.width.equalToSuperview()
//            make.height.equalTo(headerHeight)
//        }
//        segementView.snp.makeConstraints { (make) in
//            make.top.equalTo(topView.snp.bottom)
//            make.left.right.equalToSuperview()
//            make.height.equalTo(segementHeight)
//        }
//        contentScrollView.snp.makeConstraints { (make) in
//            make.top.equalTo(segementView.snp.bottom)
//            make.left.right.equalToSuperview()
//            make.height.equalTo(view.bounds.height-headerHeight-segementHeight)
//            make.bottom.equalToSuperview()
//        }
//        leftVC.view.snp.makeConstraints { (make) in
//            make.left.top.bottom.height.equalToSuperview()
//            make.width.equalTo(view.bounds.width)
//        }
//        rightVC.view.snp.makeConstraints { (make) in
//            make.left.equalTo(leftVC.view.snp.right)
//            make.width.equalTo(view.bounds.width)
//            make.top.bottom.right.equalToSuperview()
//        }
//    }
//}

class ViewController: UIViewController {

    let tableView = BaseTableView()
    var canScroll = true
    var contentCell: ContentCell?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ContentCell.self, forCellReuseIdentifier: "Cell")
        tableView.isScrollEnabled = true
        tableView.showsHorizontalScrollIndicator = false
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(bottomLayoutGuide.snp.top)
        }

        let header = TopView()
        header.backgroundColor = .red
        tableView.tableHeaderView = header
        tableView.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: headerHeight)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LeaveTop), name: NSNotification.Name.init("LeaveTop"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CenterPageViewScroll), name: NSNotification.Name.init("CenterPageViewScroll"), object: nil)
    }
    
    @objc func LeaveTop(notification: Notification) {
        canScroll = true
        contentCell?.canScroll = false
    }
    
    @objc func CenterPageViewScroll(notification: Notification) {
        let indexNum = notification.object as? NSNumber
        let index = indexNum?.intValue
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tabOffsetY = tableView.rect(forSection: 0).origin.y
        if scrollView.contentOffset.y >= tabOffsetY {
            scrollView.setContentOffset(CGPoint(x: 0, y: tabOffsetY), animated: false)
            if canScroll {
                canScroll = false
                contentCell?.canScroll = true
            }
        }else {
            if !canScroll {
                scrollView.setContentOffset(CGPoint(x: 0, y: tabOffsetY), animated: false)
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if contentCell == nil {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ContentCell
            cell.backgroundColor = .green
            contentCell = cell
        }
       
        return contentCell!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height - segementHeight
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .purple
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return segementHeight
    }
}

