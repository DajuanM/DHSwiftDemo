//
//  ViewController.swift
//  08_DHNetworkingDemo
//
//  Created by zipingfang on 2017/12/27.
//  Copyright © 2017年 com.denghui.demo. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import SwiftyJSON
import HandyJSON
import Kingfisher

class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    var newsList: [NewsModel] = []
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
        view.addSubview(tableView)
        // Do any additional setup after loading the view, typically from a nib.
//        let apiManager = MoyaProvider<APIManager>()
//        apiManager.request(.GetNewsList) { (result) in
//            switch result {
//            case .success(let response):
//
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
        
        let api = MoyaProvider<APIManager>()
        api.rx.request(.GetNewsList).asObservable().mapResponseToObject(type: NewsListModel.self).subscribe(onNext: { (listModel) in
            self.newsList = JSONDeserializer<NewsModel>.deserializeModelArrayFrom(array: listModel.top_stories)! as! [NewsModel]
            self.tableView.reloadData()
            print(self.newsList)
        }).disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        let model = newsList[indexPath.row]
        cell.titleLabel.text = model.title
        cell.imgView.kf.setImage(with: URL(string: model.image!))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

