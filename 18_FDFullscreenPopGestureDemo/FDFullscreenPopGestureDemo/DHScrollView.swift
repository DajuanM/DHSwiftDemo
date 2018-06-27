//
//  DHScrollView.swift
//  FDFullscreenPopGestureDemo
//
//  Created by aiden on 2018/6/26.
//  Copyright © 2018年 aiden. All rights reserved.
//

import UIKit

class DHScrollView: UIScrollView , UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if contentOffset.x <= 0 {
            // 1.获取命名空间
            // 通过字典的键来取值,如果键名不存在,那么取出来的值有可能就为没值.所以通过字典取出的值的类型为AnyObject?
            guard let clsName = Bundle.main.infoDictionary!["CFBundleExecutable"] else {
                print("命名空间不存在")
                return false
            }
            // 2.通过命名空间和类名转换成类
            let cls : AnyClass? = NSClassFromString((clsName as! String) + "." + "_FDFullscreenPopGestureRecognizerDelegate")
            guard let c = cls else {
                return false
            }
            if (otherGestureRecognizer.delegate?.isKind(of: c))! {
                return true
            }
        }
        return false
    }

}
