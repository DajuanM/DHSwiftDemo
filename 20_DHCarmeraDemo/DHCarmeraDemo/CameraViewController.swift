//
//  CameraViewController.swift
//  VB
//
//  Created by aiden on 2018/6/12.
//  Copyright © 2018年 MarcoLi. All rights reserved.
//

import UIKit
import AVFoundation
import SnapKit

let Z_SCREEN_WIDTH = UIScreen.main.bounds.size.width
let Z_SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let AUTO_LAYOUT = Z_SCREEN_WIDTH / 375.0

class CameraViewController: UIViewController {

    var session: AVCaptureSession!
    var input: AVCaptureDeviceInput!
    var output: AVCaptureStillImageOutput!
    var preview: UIView!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var setting: AVCapturePhotoSettings!
    var image: UIImage?

    var takePicBtn: UIButton!
    var cancelBtn: UIButton!
    var setDelegate = false
    var backImageBlock: ((_ image: UIImage)->Void)?
    var imgView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        setupUI()
        setupAVCapture()
    }

    func setupUI() {
        view.backgroundColor = .black

        preview = UIView()
        view.addSubview(preview)
        preview.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(60*AUTO_LAYOUT)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(-(132*AUTO_LAYOUT))
        }

        takePicBtn = UIButton(type: .system)
        takePicBtn.setImage(#imageLiteral(resourceName: "Buttons").withRenderingMode(.alwaysOriginal), for: .normal)
        view.addSubview(takePicBtn)
        takePicBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(-43*AUTO_LAYOUT)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 48*AUTO_LAYOUT, height: 48*AUTO_LAYOUT))
        }
        takePicBtn.addTarget(self, action: #selector(takePicBtnClicked), for: UIControlEvents.touchUpInside)

        cancelBtn = UIButton(type: .system)
        cancelBtn.setImage(UIImage(named: "ico_close")?.withRenderingMode(.alwaysOriginal), for: .normal)
        view.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-60*AUTO_LAYOUT)
            make.bottom.equalTo(-49*AUTO_LAYOUT)
            make.size.equalTo(CGSize(width: 36*AUTO_LAYOUT, height: 36*AUTO_LAYOUT))
        }
        cancelBtn.addTarget(self, action: #selector(cancelBtnClicked), for: UIControlEvents.touchUpInside)

        let imgView1 = UIImageView()
        imgView1.image = UIImage(named: "img_corner_left_up")
        preview.addSubview(imgView1)
        imgView1.snp.makeConstraints { (make) in
            make.top.equalTo(60*AUTO_LAYOUT)
            make.left.equalTo(40*AUTO_LAYOUT)
            make.size.equalTo(CGSize(width: 48*AUTO_LAYOUT, height: 48*AUTO_LAYOUT))
        }
        let imgView2 = UIImageView()
        imgView2.image = UIImage(named: "img_corner_right_up")
        preview.addSubview(imgView2)
        imgView2.snp.makeConstraints { (make) in
            make.top.equalTo(60*AUTO_LAYOUT)
            make.right.equalTo(-40*AUTO_LAYOUT)
            make.size.equalTo(CGSize(width: 48*AUTO_LAYOUT, height: 48*AUTO_LAYOUT))
        }
        let imgView3 = UIImageView()
        imgView3.image = UIImage(named: "img_corner_left_down")
        preview.addSubview(imgView3)
        imgView3.snp.makeConstraints { (make) in
            make.bottom.equalTo(-60*AUTO_LAYOUT)
            make.left.equalTo(40*AUTO_LAYOUT)
            make.size.equalTo(CGSize(width: 48*AUTO_LAYOUT, height: 48*AUTO_LAYOUT))
        }
        let imgView4 = UIImageView()
        imgView4.image = UIImage(named: "img_corner_right_down")
        preview.addSubview(imgView4)
        imgView4.snp.makeConstraints { (make) in
            make.bottom.equalTo(-60*AUTO_LAYOUT)
            make.right.equalTo(-40*AUTO_LAYOUT)
            make.size.equalTo(CGSize(width: 48*AUTO_LAYOUT, height: 48*AUTO_LAYOUT))
        }
    }

    func setupAVCapture() {
        session = AVCaptureSession()
        let device = AVCaptureDevice.default(for: AVMediaType.video)
        try? device?.lockForConfiguration()
        device?.flashMode = .auto
        device?.unlockForConfiguration()

        input = try? AVCaptureDeviceInput(device: device!)
        output = AVCaptureStillImageOutput()
        output.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
        print(input)


//        output.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
        if session.canAddInput(input) {
            session.addInput(input)
        }
        if session.canAddOutput(output) {
            session.addOutput(output)
        }
        view.layoutIfNeeded()
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer.frame = preview.bounds
        previewLayer.backgroundColor = UIColor.red.cgColor
        preview.layer.insertSublayer(previewLayer, at: 0)
        session.startRunning()
    }

    @objc func takePicBtnClicked() {
        takePicture()
    }

    @objc func cancelBtnClicked() {
        session.stopRunning()
        dismiss(animated: true, completion: nil)
    }

    func takePicture() {
        guard let stillImageConnection = output.connection(with: AVMediaType.video) else {
            print("拍摄失败！")
            return
        }
        let curDeviceOrientation = UIDevice.current.orientation
        if let avcaptureOrientation = self.avOrientationForDeviceOrientation(deviceOrientation: curDeviceOrientation) {
            stillImageConnection.videoOrientation = avcaptureOrientation
            stillImageConnection.videoScaleAndCropFactor = 1
        }
        output.captureStillImageAsynchronously(from: stillImageConnection) { (imageDataSampleBuffer, error) in
            if let error_ = error {
                print(error_)
                return
            }
            guard let _ = imageDataSampleBuffer else {
                return
            }

            let curDeviceOrientation = UIDevice.current.orientation
            if let avcaptureOrientation = self.avOrientationForDeviceOrientation(deviceOrientation: curDeviceOrientation) {
                stillImageConnection.videoOrientation = avcaptureOrientation
                stillImageConnection.videoScaleAndCropFactor = 1
            }
            if let jpegData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer!) {
                if let tempImage = UIImage(data: jpegData, scale: 1) {
                    if let tempCgImage = tempImage.cgImage {
                        let image = UIImage(cgImage: tempCgImage, scale: 0.1, orientation: UIImageOrientation.up)
                        //+36是因为预览层显示的是整个拍摄区的中心，而显示层又向上偏移了距离屏幕中心36
                        let x = (120+36) * AUTO_LAYOUT * CGFloat((image.cgImage?.width)!) / Z_SCREEN_HEIGHT
                        let y = 40 * AUTO_LAYOUT * CGFloat((image.cgImage?.height)!) / Z_SCREEN_WIDTH
                        let width = (self.preview.bounds.height - 120 * AUTO_LAYOUT) * CGFloat((image.cgImage?.width)!) / Z_SCREEN_HEIGHT
                        let height = (self.preview.bounds.width - 80 * AUTO_LAYOUT) * CGFloat((image.cgImage?.height)!) / Z_SCREEN_WIDTH
                        let backImg = self.clipImage(image: image, rect: CGRect(x: x, y: y, width: width, height: height))
                        self.backImageBlock?(backImg)
                        self.session.stopRunning()
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }

    func avOrientationForDeviceOrientation(deviceOrientation: UIDeviceOrientation) -> AVCaptureVideoOrientation? {
        if (deviceOrientation == UIDeviceOrientation.landscapeLeft) {
            return AVCaptureVideoOrientation.landscapeRight
        } else if (deviceOrientation == UIDeviceOrientation.landscapeRight){
            return AVCaptureVideoOrientation.landscapeLeft
        } else {
            return nil
        }
    }

    func clipImage(image: UIImage, rect: CGRect) -> UIImage {
        //把像素rect 转化为 点rect（如无转化则按原图像素取部分图片）
        let scale = UIScreen.main.scale
//        let x=rect.origin.x*scale, y=rect.origin.y*scale, w=rect.size.width*scale, h=rect.size.height*scale
        let dianRect = rect//CGRect(x: x, y: y, width: w, height: h)
        //截取部分图片并生成新图片
        let sourceImageRef = image.cgImage
        let newImageRef = sourceImageRef?.cropping(to: dianRect)
        let newImage = UIImage(cgImage: newImageRef!, scale: scale, orientation: UIImageOrientation.up)
        return newImage
    }
}

