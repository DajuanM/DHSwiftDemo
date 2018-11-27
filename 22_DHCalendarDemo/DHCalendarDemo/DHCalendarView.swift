//
//  DHCalendarView.swift
//  VB
//
//  Created by mac on 2018/10/15.
//  Copyright © 2018 MarcoLi. All rights reserved.
//

import UIKit
import SnapKit

class VBDateFormatter: DateFormatter {
    static let shared = VBDateFormatter()
    private override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func format(_ str: String) -> VBDateFormatter {
        self.dateFormat = str
        return self
    }
}

extension UILabel {
    class func label(textColor: UIColor, font: UIFont) -> UILabel {
        let label = UILabel()
        label.textColor = textColor
        label.font = font
        return label
    }
}

extension UIColor {
    static func vb_black(alpha: CGFloat) -> UIColor {
        return UIColor.black.withAlphaComponent(alpha)
    }
}

extension UIFont {
    class func vb_number_font(size: CGFloat) -> UIFont {
        return UIFont.init(name: "SFUDINMitAlt", size: size)!
    }
    class func vb_normal_font(size: CGFloat) -> UIFont {
        return UIFont.init(name: "PingFangSC-Regular", size: size)!
    }
    class func vb_medium_font(size: CGFloat) -> UIFont {
        return UIFont.init(name: "PingFangSC-Medium", size: size)!
    }
    class func vb_bold_font(size: CGFloat) -> UIFont {
        return UIFont.init(name: "PingFangSC-Semibold", size: size)!
    }
}

extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self.classForCoder())
    }
}

extension String {
    func subString(start:Int, length:Int = -1) -> String {
        if self == "" {
            return ""
        }
        if self.count < (start + length) {
            return self
        }
        var len = length
        if len == -1 {
            len = self.count - start
        }
        let st = self.index(startIndex, offsetBy:start)
        let en = self.index(st, offsetBy:len)
        return String(self[st ..< en])
    }
}

let Z_SCREEN_WIDTH = UIScreen.main.bounds.size.width
let Z_SCREEN_HEIGHT = UIScreen.main.bounds.size.height

class DHCalendarView: UIView, UIScrollViewDelegate {
    
    let topView = UIView()
    let weekView = UIView()
    var collectionView: UICollectionView!
    
    let bottomView = UIView()
    
    let dateLabel = UILabel.label(textColor: UIColor.vb_black(alpha: 1.0), font: UIFont.vb_bold_font(size: 16))
    let lastBtn = UIButton()
    let nextBtn = UIButton()
    
    let cancelBtn = UIButton(type: .system)
    let confirmBtn = UIButton(type: .system)
    
    var confirmBtnClicked: ((Date?, Date?)->Void)?
    var cancelBtnClicked: (()->Void)?

    var date = Date()
    var startDate: Date? = Date()
    var endDate: Date? = Date()
    
    init() {
        super.init(frame: CGRect(x: 0, y: 100, width: Z_SCREEN_WIDTH, height: 175+(Z_SCREEN_WIDTH/7.0)*6))
        setup()
    }

    init(_ date: Date = Date(), _ startDate: Date? = Date(), _ endDate: Date? = Date()) {
        super.init(frame: CGRect(x: 0, y: 100, width: Z_SCREEN_WIDTH, height: 175+(Z_SCREEN_WIDTH/7.0)*6))
        self.date = date
        self.startDate = startDate
        self.endDate = endDate
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup() {
        backgroundColor = .white
        
        setupTopView()
        setupWeekView()
        setupCollectionView()
        setupBottomView()
        
        addSubview(topView)
        addSubview(weekView)
        addSubview(bottomView)
        
        topView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(86)
        }
        weekView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(29)
        }
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(weekView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo((Z_SCREEN_WIDTH/7.0)*6)
        }
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(60)
        }
    }
    
    func setupTopView() {
        let formatter = VBDateFormatter.shared.format("yyyy年MM月")
        dateLabel.text = formatter.string(from: date)
        dateLabel.textAlignment = .center
        lastBtn.setImage(UIImage(named: "ico_chevron_circle_left_grey"), for: .normal)
        nextBtn.setImage(UIImage(named: "ico_chevron_circle_right_grey"), for: .normal)
        
        topView.addSubview(lastBtn)
        topView.addSubview(nextBtn)
        topView.addSubview(dateLabel)
        
        lastBtn.addTarget(self, action: #selector(lastBtnClicked), for: .touchUpInside)
        nextBtn.addTarget(self, action: #selector(nextBtnClicked), for: .touchUpInside)
        
        lastBtn.snp.makeConstraints { (make) in
            make.left.equalTo(8)
            make.width.height.equalTo(40)
            make.centerY.equalToSuperview()
        }
        nextBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-8)
            make.width.height.equalTo(40)
            make.centerY.equalToSuperview()
        }
        dateLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    @objc func lastBtnClicked() {
        date = lastMonth(date)
        collectionView.reloadData()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月"
        dateLabel.text = formatter.string(from: date)
    }
    
    @objc func nextBtnClicked() {
        date = nextMonth(date)
        collectionView.reloadData()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月"
        dateLabel.text = formatter.string(from: date)
    }
    
    @objc func confirmBtnHandler() {
        self.confirmBtnClicked?(self.startDate, self.endDate)
    }
    
    @objc func cancelBtnHandler() {
        self.cancelBtnClicked?()
    }
    
    func setupWeekView() {
        let weekArr = ["周日", "周一", "周二", "周三", "周四", "周五", "周六"]
        for (i, week) in weekArr.enumerated() {
            let label = UILabel.label(textColor: UIColor.vb_black(alpha: 0.4), font: UIFont.vb_normal_font(size: 10))
            label.textAlignment = .center
            label.text = week
            weekView.addSubview(label)
            
            label.snp.makeConstraints { (make) in
                make.left.equalTo(CGFloat(i)*((Z_SCREEN_WIDTH)/7.0))
                make.centerY.equalToSuperview()
                make.width.equalTo((Z_SCREEN_WIDTH)/7.0)
            }
        }
    }
    
    func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.register(DHDayItemCell.self, forCellWithReuseIdentifier: DHDayItemCell.identifier)
        addSubview(collectionView)
        collectionView.contentSize = CGSize(width: Z_SCREEN_WIDTH*3.0, height: (Z_SCREEN_WIDTH/7.0)*6)
        collectionView.setContentOffset(CGPoint(x: Z_SCREEN_WIDTH, y: 0), animated: false)
    }
    
    func setupBottomView() {
        confirmBtn.setTitle("确定", for: .normal)
        confirmBtn.layer.cornerRadius = 8
        confirmBtn.layer.borderWidth = 1.0
        confirmBtn.layer.borderColor = UIColor.vb_black(alpha: 0.4).cgColor
        confirmBtn.layer.masksToBounds = true
        confirmBtn.setTitleColor(UIColor.vb_black(alpha: 0.6), for: .normal)
        confirmBtn.titleLabel?.font = UIFont.vb_normal_font(size: 14)
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.layer.cornerRadius = 8
        cancelBtn.layer.borderWidth = 1.0
        cancelBtn.layer.borderColor = UIColor.vb_black(alpha: 0.4).cgColor
        cancelBtn.layer.masksToBounds = true
        cancelBtn.setTitleColor(UIColor.vb_black(alpha: 0.6), for: .normal)
        cancelBtn.titleLabel?.font = UIFont.vb_normal_font(size: 14)
        
        bottomView.addSubview(confirmBtn)
        bottomView.addSubview(cancelBtn)
        
        confirmBtn.addTarget(self, action: #selector(confirmBtnHandler), for: .touchUpInside)
        cancelBtn.addTarget(self, action: #selector(cancelBtnHandler), for: .touchUpInside)
        
        confirmBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-16)
            make.centerY.equalToSuperview()
            make.height.equalTo(36)
        }
        
        cancelBtn.snp.makeConstraints { (make) in
            make.right.equalTo(confirmBtn.snp.left).offset(-16)
            make.centerY.equalToSuperview()
            make.height.equalTo(36)
            make.left.equalTo(16)
            make.width.equalTo(confirmBtn)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let index = offsetX / scrollView.bounds.width
        if index == 0 {
            date = lastMonth(date)
            collectionView.setContentOffset(CGPoint(x: scrollView.bounds.width, y: 0), animated: false)
        }else if index == 2 {
            date = nextMonth(date)
            collectionView.setContentOffset(CGPoint(x: scrollView.bounds.width, y: 0), animated: false)
        }
        collectionView.reloadData()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月"
        dateLabel.text = formatter.string(from: date)
    }
}

extension DHCalendarView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DHDayItemCell.identifier, for: indexPath) as! DHDayItemCell
        var date: Date?
        switch indexPath.section {
        case 0:
            date = lastMonth(self.date)
        case 1:
            date = self.date
        default:
            date = nextMonth(self.date)
        }
        
        let firstDay = getStartDateInMonth(date)
        let firstDayWeek = getWeek(firstDay)
        let daysCount = getDaysCountInMonth(date) ?? 0
        let i = indexPath.row / 6
        let j = indexPath.row % 6
        let index = i + j * 7
        if index < firstDayWeek || (index-firstDayWeek+1) > daysCount {
            cell.dayLabel.text = ""
            cell.status = .normal
            cell.date = nil
        }else {
            var dateComponents = DateComponents()
            dateComponents.day = index-firstDayWeek
            let itemDate = NSCalendar.current.date(byAdding: dateComponents, to: firstDay ?? Date())
            cell.date = itemDate
            cell.dayLabel.text = "\(getDay(itemDate))"
            cell.taped = { [weak self] (date) in
                guard let `self` = self else {return}
                if self.startDate == nil || (self.startDate != nil && self.endDate != nil) {
                    self.startDate = date
                    self.endDate = nil
                }else {
                    let startTimeInterval = self.startDate?.timeIntervalSince1970
                    let timeInterval = date.timeIntervalSince1970
                    if startTimeInterval < timeInterval {
                        self.endDate = date
                    }else {
                        self.endDate = self.startDate
                        self.startDate = date
                        
                    }
                }
                self.collectionView.reloadData()
            }
            refreshItem(cell, startDate, endDate)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIScreen.main.currentMode?.size.equalTo(CGSize(width: 1125, height: 2436)) ?? false {
            return CGSize(width: (Z_SCREEN_WIDTH / 7.0), height: 53)
        }
        //解决出现白线问题
        var width = Int((Z_SCREEN_WIDTH / 7.0))
        let collectionIntHeight = Int((Z_SCREEN_WIDTH / 7.0) * 6)
        var height = Int((collectionIntHeight / 6))
        let indexX = Int(Z_SCREEN_WIDTH) % 7
        let indexY = collectionIntHeight % 6
        let x = indexPath.row / 6
        let y = indexPath.row % 6
        if x < indexX {
            width = width + 1
        }
        if y < indexY {
            height = height + 1
        }else if y == indexY {
            let cellH = CGFloat(height) + (Z_SCREEN_WIDTH / 7.0) * 6.0 - CGFloat(collectionIntHeight)
            return CGSize(width: CGFloat(width), height: cellH)
        }
        return CGSize(width: CGFloat(width), height: CGFloat(height))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func refreshItem(_ item: DHDayItemCell, _ startDate: Date?, _ endDate: Date?) {
        guard let startDate = startDate else {
            return
        }
        
        let formatter = VBDateFormatter.shared.format("yyyy-MM-dd HH:mm:ss")
        let startStr = formatter.string(from: startDate).subString(start: 0, length: 11) + "00:00:00"
        guard let start = formatter.date(from: startStr) else {return}
        let startTimeInterval = start.timeIntervalSince1970
        
        let endDate = endDate ?? start
        let endNextStr = formatter.string(from: nextDay(endDate)).subString(start: 0, length: 11) + "00:00:00"
        let endNext = formatter.date(from: endNextStr)
        let endNextTimeInterval = endNext?.timeIntervalSince1970
        
        let timeInterval = item.date?.timeIntervalSince1970
        guard let date = item.date else {return}
        let dateStr = formatter.string(from: date).subString(start: 0, length: 11) + "00:00:00"
        let endStr = formatter.string(from: endDate).subString(start: 0, length: 11) + "00:00:00"
        if timeInterval > startTimeInterval, timeInterval < endNextTimeInterval {
            if startStr == endStr {
                item.status = .single
            }else {
                if dateStr == startStr {
                    item.status = .start
                }else if dateStr == endStr {
                    item.status = .end
                }else {
                    item.status = .middle
                }
            }
        }else {
            item.status = .normal
        }
    }
}

class DHDayItemCell: UICollectionViewCell {
    
    enum DayItemStatus {
        case normal
        case start
        case middle
        case end
        case single
    }
    
    var date: Date?
    
    let dayLabel = UILabel.label(textColor: UIColor.vb_black(alpha: 0.9), font: UIFont.vb_medium_font(size: 16))
    let bgImgView = UIImageView()
    var taped: ((Date)->Void)?
    
    var status: DayItemStatus = .normal {
        willSet {
            switch newValue {
            case .normal:
                dayLabel.textColor = UIColor.vb_black(alpha: 0.9)
                bgImgView.image = nil
            case .start:
                dayLabel.textColor = .white
                bgImgView.image = UIImage(named: "img_pickdate_bg_start")
            case .middle:
                dayLabel.textColor = .white
                bgImgView.image = UIImage(named: "img_pickdate_bg_middle")
            case .end:
                dayLabel.textColor = .white
                bgImgView.image = UIImage(named: "img_pickdate_bg_end")
            case .single:
                dayLabel.textColor = .white
                bgImgView.image = UIImage(named: "img_pickdate_bg_single")
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup() {
        backgroundColor = .white
        dayLabel.text = "1"
        dayLabel.textAlignment = .center
        
        addSubview(bgImgView)
        addSubview(dayLabel)
        let tapBtn = UIButton()
        addSubview(tapBtn)

        tapBtn.addTarget(self, action: #selector(tapBtnClicked), for: .touchUpInside)
        
        dayLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        bgImgView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0))
        }
        tapBtn.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func tapBtnClicked() {
        if let date = date {
            taped?(date)
        }
    }
}

func getWeek(_ date: Date?) -> Int {
    guard let date = date else {return 0}
    let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.chinese)
    let componet = calendar?.components(NSCalendar.Unit.weekday, from: date)
    return (componet?.weekday ?? 0) - 1
}

func getDay(_ date: Date?) -> Int {
    guard let date = date else {return 0}
    let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
    let componet = calendar?.components(NSCalendar.Unit.day, from: date)
    return componet?.day ?? 0
}

func getMonth(_ date: Date?) -> Int {
    guard let date = date else {return 0}
    let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
    let componet = calendar?.components(NSCalendar.Unit.month, from: date)
    return componet?.month ?? 0
}

func getDaysCountInMonth(_ date: Date?) -> Int? {
    guard let date = date else {return nil}
    let calendar = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.gregorian)
    let range = calendar?.range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: date)
    return range?.length ?? 0
}

func lastDay(_ date: Date?) -> Date {
    guard let date = date else {return Date()}
    var dateComponents = DateComponents()
    dateComponents.day = -1
    return NSCalendar.current.date(byAdding: dateComponents, to: date) ?? Date()
}

func nextDay(_ date: Date?) -> Date {
    guard let date = date else {return Date()}
    var dateComponents = DateComponents()
    dateComponents.day = 1
    return NSCalendar.current.date(byAdding: dateComponents, to: date) ?? Date()
}

func lastMonth(_ date: Date?) -> Date {
    guard let date = date else {return Date()}
    var dateComponents = DateComponents()
    dateComponents.month = -1
    return NSCalendar.current.date(byAdding: dateComponents, to: date) ?? Date()
}

func nextMonth(_ date: Date?) -> Date {
    guard let date = date else {return Date()}
    var dateComponents = DateComponents()
    dateComponents.month = 1
    return NSCalendar.current.date(byAdding: dateComponents, to: date) ?? Date()
}

func getStartDateInMonth(_ date: Date?) -> Date? {
    guard let date = date else {return Date()}
    let day = getDay(date)
    var dateComponents = DateComponents()
    dateComponents.day = -(day-1)
    return NSCalendar.current.date(byAdding: dateComponents, to: date) ?? Date()
}

