//
//  ViewController.swift
//  DHCalendarDemo
//
//  Created by mac on 2018/11/27.
//  Copyright © 2018 aiden. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let calendarVuew = DHCalendarView()
        view.addSubview(calendarVuew)
    }


}

