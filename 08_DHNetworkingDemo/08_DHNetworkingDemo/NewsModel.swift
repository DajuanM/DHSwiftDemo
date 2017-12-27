//
//  NewsModel.swift
//  08_DHNetworkingDemo
//
//  Created by zipingfang on 2017/12/27.
//  Copyright © 2017年 com.denghui.demo. All rights reserved.
//

import Foundation
import HandyJSON

class NewsListModel: HandyJSON {
    var date: String?
    var top_stories: [Any] = []
    required init() {
        
    }
}

class NewsModel: HandyJSON {
    var title: String?
    var ga_prefix: String?
    var id: String?
    var image: String?
    var type: String?
    required init() {
        
    }
}
