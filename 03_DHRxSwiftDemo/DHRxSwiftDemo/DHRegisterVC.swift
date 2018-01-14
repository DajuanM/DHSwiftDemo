//
//  DHRegisterVC.swift
//  DHRxSwiftDemo
//
//  Created by swartz006 on 2017/8/9.
//  Copyright © 2017年 denghui. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DHRegisterVC: UIViewController {
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var psdTF: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var nameTipLabel: UILabel!
    @IBOutlet weak var psdTipLabel: UILabel!
    @IBOutlet weak var repeatTF: UITextField!
    @IBOutlet weak var repeatTipLabel: UILabel!
    
    let disposeBag = DisposeBag()
    let registerVM = DHRegisterVM()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameTF.rx.text.orEmpty.bind(to: registerVM.name).addDisposableTo(disposeBag)
        //可以直接绑定 也可直接监听
        registerVM.nameValid.bind(to: nameTipLabel.rx.validResult).addDisposableTo(disposeBag)
//        registerVM.nameValid.subscribe(onNext: { (result) in
//            switch result {
//            case .empty:
//                self.nameTipLabel.isHidden = true
//            default:
//                self.nameTipLabel.isHidden = false
//                self.nameTipLabel.text = result.description
//                self.nameTipLabel.textColor = result.textColor
//            }
//        }).addDisposableTo(disposeBag)
        
        psdTF.rx.text.orEmpty.bind(to: registerVM.psd).addDisposableTo(disposeBag)
        registerVM.psdValid.bind(to: psdTipLabel.rx.validResult).addDisposableTo(disposeBag)
        
        repeatTF.rx.text.orEmpty.bind(to: registerVM.repeatPsd).addDisposableTo(disposeBag)
        registerVM.repeatPsdValid.bind(to: repeatTipLabel.rx.validResult).addDisposableTo(disposeBag)
        
        registerVM.registerBtnEnable.subscribe(onNext: { (result) in
            if result {
                self.registerBtn.backgroundColor = UIColor.red
                self.registerBtn.isUserInteractionEnabled = true
            }else{
                self.registerBtn.backgroundColor = UIColor.gray
                 self.registerBtn.isUserInteractionEnabled = false
            }
        }).addDisposableTo(disposeBag)
        
        //注册按钮点击事件
        registerBtn.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { (button) in
            print("注册按钮点击了")
        }).addDisposableTo(disposeBag)
        
        
        //常见用法
//        test()
    }
    
    func test() {
        //KVO
        self.nameTF.rx.observe(String.self, "text").subscribe(onNext: { (name) in
            print(name)
        }).addDisposableTo(disposeBag)
        //通知
        NotificationCenter.default.rx.notification(Notification.Name(rawValue: "notification"), object: nil).subscribe(onNext: { (notify) in
            
        }).addDisposableTo(disposeBag)
    }
}



