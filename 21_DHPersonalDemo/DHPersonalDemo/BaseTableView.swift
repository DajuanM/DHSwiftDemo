//
//  BaseTableView.swift
//  DHPersonalDemo
//
//  Created by mac on 2018/9/11.
//  Copyright © 2018年 aiden. All rights reserved.
//

import UIKit

class BaseTableView: UITableView, UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return gestureRecognizer.isKind(of: UIPanGestureRecognizer.self) && otherGestureRecognizer.isKind(of: UIPanGestureRecognizer.self)
        return true
    }
}
