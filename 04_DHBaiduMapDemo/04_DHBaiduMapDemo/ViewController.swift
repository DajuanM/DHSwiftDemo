//
//  ViewController.swift
//  04_DHBaiduMapDemo
//
//  Created by swartz006 on 2017/8/11.
//  Copyright © 2017年 denghui. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var mapView: BMKMapView!
    var locService: BMKLocationService!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapView = BMKMapView(frame: view.bounds)
        view.addSubview(mapView)
        
        locService = BMKLocationService()
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
//        BMKLocationService.setLocationDesiredAccuracy(kCLLocationAccuracyBest)
        locService.desiredAccuracy = kCLLocationAccuracyBest
        //指定最小距离更新(米)，默认：kCLDistanceFilterNone
//        BMKLocationService.setLocationDistanceFilter(10)
        locService.distanceFilter = 10
        locService.startUserLocationService()
        mapView.showsUserLocation = true
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
        
        
        //画线
        addLine()
    }
    
    func addLine() {
        // 添加折线覆盖物 在北京
        var coor: [CLLocationCoordinate2D] = []
        let lat = [39.832136, 39.832136, 39.902136, 39.902136]
        let long = [116.34095, 116.42095, 116.42095, 116.44095]
        for index in 0..<4 {
            var loc = CLLocationCoordinate2D()
            loc.latitude = lat[index]
            loc.longitude = long[index]
            coor.append(loc)
        }
        let polyLine = BMKPolyline(coordinates: &coor, count: 4)
        mapView.add(polyLine)
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
    
}

//MARK: BMKMapViewDelegate
extension ViewController: BMKMapViewDelegate {
    func mapView(_ mapView: BMKMapView!, viewFor annotation: BMKAnnotation!) -> BMKAnnotationView! {
        if annotation.isKind(of: BMKPointAnnotation.self) {
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "Annotation")
            if annotationView == nil {
                annotationView = BMKPinAnnotationView(annotation: annotation, reuseIdentifier: "Annotation")
            }
            annotationView?.tintColor = UIColor.purple
            annotationView?.canShowCallout = true //设置气泡可以弹出
            annotationView?.enabled3D = true //设置3D效果
            annotationView?.isDraggable = true //设置标注可以拖动
            return annotationView
        }
        return nil
    }
    
    func mapView(_ mapView: BMKMapView!, viewFor overlay: BMKOverlay!) -> BMKOverlayView! {
        if overlay.isKind(of: BMKPolyline.self) {
            let overlayView = BMKPolylineView(overlay: overlay)
            overlayView?.strokeColor = UIColor.red
            overlayView?.lineWidth = 2
            return overlayView
        }
        return nil
    }
}

//MARK: BMKLocationServiceDelegate
extension ViewController: BMKLocationServiceDelegate {
    //处理方向变更信息
    //    func didUpdateUserHeading(_ userLocation: BMKUserLocation!) {
    //        mapView.updateLocationData(userLocation)
    //    }
    //处理位置坐标更新
    func didUpdate(_ userLocation: BMKUserLocation!) {
        mapView.updateLocationData(userLocation)
        let annotation = BMKPointAnnotation()
        annotation.coordinate = userLocation.location.coordinate
        annotation.title = "我的位置"
        mapView.addAnnotation(annotation)
        
    }
}

