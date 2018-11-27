//
//  ContentCell.swift
//  DHPersonalDemo
//
//  Created by mac on 2018/9/11.
//  Copyright © 2018年 aiden. All rights reserved.
//

import UIKit
import SnapKit

class ContentCell: UITableViewCell {
    
    var scrollView = UIScrollView()
    let pageViewCtrl = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.horizontal, options: [UIPageViewControllerOptionSpineLocationKey: UIPageViewControllerSpineLocation.min])
    var dataArr: [UIViewController] = []
    var canScroll = false {
        willSet {
            for vc in dataArr {
                let baseVC = vc as! BaseTableViewController
                baseVC.canScroll = newValue
                if !newValue {
                    baseVC.tableView.contentOffset = .zero
                }
            }
        }
    }
    var selectIndex = 0 {
        willSet {
            pageViewCtrl.setViewControllers([dataArr[newValue]], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(pageViewCtrl.view)
        pageViewCtrl.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        let leftVC = LeftViewController()
        let rightVC = RightViewController()
        dataArr = [leftVC, rightVC]
        pageViewCtrl.dataSource = self
        pageViewCtrl.delegate = self
        pageViewCtrl.setViewControllers([dataArr[0]], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        for sview in pageViewCtrl.view.subviews {
            if sview.isKind(of: UIScrollView.self) {
                scrollView = sview as! UIScrollView
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContentCell: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = dataArr.index(of: viewController)
        if index == 0 || index == nil {
            return nil
        }
        index = index! - 1
        return dataArr[index!]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = dataArr.index(of: viewController)
        if index == dataArr.count - 1 || index == nil {
            return nil
        }
        index = index! + 1
        return dataArr[index!]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        var index = dataArr.index(of: (pageViewCtrl.viewControllers?.first)!)
        NotificationCenter.default.post(name: NSNotification.Name.init("CenterPageViewScroll"), object: NSNumber(value: index!))
    }
}
