//
//  DHRxExtension.swift
//  DHRxSwiftDemo
//
//  Created by swartz006 on 2017/8/9.
//  Copyright © 2017年 denghui. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UITextField {
    var inputEnable: UIBindingObserver<Base, ValidationResult> {
        return UIBindingObserver(UIElement: base, binding: { (textField, result) in
            textField.isEnabled = result.isValid
        })
    }
}

extension Reactive where Base: UILabel {
    var validResult: UIBindingObserver<Base, ValidationResult> {
        return UIBindingObserver(UIElement: base, binding: { (label, result) in
            switch result {
            case .empty:
                label.isHidden = true
            default:
                label.isHidden = false
                label.text = result.description
                label.textColor = result.textColor
            }
        })
    }
}
