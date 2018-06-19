//
//  DHView1.swift
//  DHYNDropDownMenuDemo
//
//  Created by aiden on 2018/5/23.
//  Copyright © 2018年 aiden. All rights reserved.
//

import UIKit
import YNDropDownMenu

class DHView1: YNDropDownView {
    let cellHeight: CGFloat = 40.0
    var tableView: UITableView!
    var titles: [String] = []
    var selectedRow = 0

    override init(frame: CGRect) {
        super.init(frame: frame)

    }

    init(titles: [String]) {
        var height: CGFloat = 0.0
        height = CGFloat(titles.count) * cellHeight
        if titles.count > 8 {
            height = 8.0 * cellHeight
        }
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height))
        self.titles = titles
        tableView = UITableView(frame: bounds)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        addSubview(tableView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DHView1: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = titles[indexPath.row]
        if indexPath.row == selectedRow {
            cell.textLabel?.textColor = .red
        }else {
            cell.textLabel?.textColor = .black
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        tableView.reloadData()
    }
}
