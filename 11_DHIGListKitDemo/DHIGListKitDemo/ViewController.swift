//
//  ViewController.swift
//  DHIGListKitDemo
//
//  Created by aiden on 2018/1/14.
//  Copyright © 2018年 aiden. All rights reserved.
//

import UIKit
import IGListKit

class ViewController: UIViewController {
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var data = [
        DHTitleModel(title: "123"),
        DHTitleModel(title: "234"),
        DHImgModel(color: UIColor.red),
        DHImgModel(color: UIColor.purple)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.backgroundColor = UIColor.white
        collectionView.frame = view.bounds
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: ListAdapterDataSource {

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return data as! [ListDiffable]
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is DHTitleModel {
            return DHTitleSectionController()
        }else {
            return DHImgSectionController()
        }
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

