//
//  DHValidationResultEnum.swift
//  DHRxSwiftDemo
//
//  Created by swartz006 on 2017/8/9.
//  Copyright © 2017年 denghui. All rights reserved.
//

import Foundation
import UIKit

enum ValidationResult {
    case ok(message: String)
    case fail(message: String)
    case empty
}

extension ValidationResult {
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}

extension ValidationResult {
    var textColor: UIColor {
        switch self {
        case .ok:
            return UIColor.purple
        case .empty:
            return UIColor.black
        case .fail:
            return UIColor.red
            
        }
    }
}

extension ValidationResult {
    var description: String {
        switch self {
        case let .ok(message):
            return message
        case .empty:
            return ""
        case let .fail(message):
            return message
        }
    }
}
