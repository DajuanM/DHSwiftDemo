//
//  DHRegisterVM.swift
//  DHRxSwiftDemo
//
//  Created by swartz006 on 2017/8/9.
//  Copyright © 2017年 denghui. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
/// 最小字符数
let charactersCount = 6




class DHRegisterVM {
    let name = Variable<String>("")
    let psd = Variable<String>("")
    let repeatPsd = Variable<String>("")
    
    let nameValid: Observable<ValidationResult>
    let psdValid: Observable<ValidationResult>
    let repeatPsdValid: Observable<ValidationResult>
    let registerBtnEnable: Observable<Bool>
    init() {
        //shareReplay 让监听对象可被共享
        nameValid = name.asObservable().flatMap({ (name) -> Observable<ValidationResult> in
            if name.characters.count == 0 {
                return Observable.just(ValidationResult.empty)
            }
            if name.characters.count < charactersCount {
                return Observable.just(ValidationResult.fail(message: "位数不能小于\(charactersCount)位"))
            }
            return Observable.just(ValidationResult.ok(message: "正确"))
        }).shareReplay(1)
        
        psdValid = psd.asObservable().flatMap({ (psd) -> Observable<ValidationResult> in
            if psd.characters.count == 0 {
                return Observable.just(ValidationResult.empty)
            }
            if psd.characters.count < charactersCount {
                return Observable.just(ValidationResult.fail(message: "位数不能小于\(charactersCount)位"))
            }
            return Observable.just(ValidationResult.ok(message: "正确"))
        }).shareReplay(1)
        
        repeatPsdValid = Observable.combineLatest(psd.asObservable(), repeatPsd.asObservable(), resultSelector: { (psd, repeatPsd) -> ValidationResult in
            if psd.characters.count == 0 || repeatPsd.characters.count == 0 {
                return ValidationResult.empty
            }
            if repeatPsd == psd {
                return ValidationResult.ok(message: "正确")
            }
            return ValidationResult.fail(message: "密码不一致")
        }).shareReplay(1)
        
        registerBtnEnable = Observable.combineLatest(nameValid, psdValid, repeatPsdValid, resultSelector: { (nameValid, psdValid, repeatValid) -> Bool in
            if nameValid.isValid && psdValid.isValid && repeatValid.isValid {
                return true
            }
            return false
        }).shareReplay(1)
    }
}
