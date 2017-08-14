//
//  ViewController.swift
//  04_DHBaiduMapDemo
//
//  Created by swartz006 on 2017/8/11.
//  Copyright © 2017年 denghui. All rights reserved.
//

import UIKit

class ViewController: UIViewController, BMKMapViewDelegate, BMKLocationServiceDelegate {
    var mapView: BMKMapView!
    var locService: BMKLocationService!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapView = BMKMapView(frame: view.bounds)
        view.addSubview(mapView)
        
         // 设置定位精确度，默认：kCLLocationAccuracyBest
        /*
         设置位置精确度有很多可选值，大致上包括以下几条：
         kCLLocationAccuracyBest：设备使用电池供电时候最高的精度
         kCLLocationAccuracyBestForNavigation：导航情况下最高精度,一般要有外接电源时才能使用
         kCLLocationAccuracyNearestTenMeters：十米误差范围
         kCLLocationAccuracyHundredMeters:百米误差范围
         kCLLocationAccuracyKilometer:千米误差范围
         kCLLocationAccuracyThreeKilometers:三千米误差范围
         */
        BMKLocationService.setLocationDesiredAccuracy(kCLLocationAccuracyBest)
        
        
        //指定最小距离更新(米)，默认：kCLDistanceFilterNone
        BMKLocationService.setLocationDistanceFilter(10)
        locService = BMKLocationService()
        locService.startUserLocationService()
        mapView.showsUserLocation = false
        
        //设置位置跟踪态
        /*
         设置位置跟踪态也有以下几种：
         
         BMKUserTrackingModeNone：不进行用户位置跟踪
         BMKUserTrackingModeFollow：跟踪用户位置
         BMKUserTrackingModeFollowWithHeading：跟踪用户位置并且跟踪用户前进方向
         */
        mapView.userTrackingMode = BMKUserTrackingModeFollowWithHeading
        
        //显示定位图层
        mapView.showsUserLocation = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapView.viewWillAppear()
        mapView.delegate = self // 此处记得不用的时候需要置nil，否则影响内存的释放
        locService.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mapView.viewWillDisappear()
        mapView.delegate = nil // 不用时，置nil
        locService.delegate = nil
    }
    
    //MARK: BMKMapViewDelegate
    
    //MARK: BMKLocationServiceDelegate
    //处理方向变更信息
//    func didUpdateUserHeading(_ userLocation: BMKUserLocation!) {
//        mapView.updateLocationData(userLocation)
//    }
    //处理位置坐标更新
    func didUpdate(_ userLocation: BMKUserLocation!) {
        mapView.updateLocationData(userLocation)
    }
}

