//
//  DHVedioVC.swift
//  DHBMPlayerDemo
//
//  Created by aiden on 2018/1/19.
//  Copyright © 2018年 com.denghui.demo. All rights reserved.
//

import UIKit
import BMPlayer
import AVFoundation
import NVActivityIndicatorView
import SnapKit

class DHVedioVC: UIViewController {
//
//    @IBOutlet weak var playerView: BMPlayer!
    var playerView: BMPlayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        BMPlayerConf.allowLog = false
        BMPlayerConf.shouldAutoPlay = true
        BMPlayerConf.tintColor = UIColor.white
        BMPlayerConf.topBarShowInCase = .always
        BMPlayerConf.loaderType = NVActivityIndicatorType.ballRotateChase
        BMPlayerConf.topBarShowInCase = .horizantalOnly

        playerView = BMPlayer()
        view.addSubview(playerView)
        playerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(200)
        }
        let label = UILabel()
        label.textColor = .white
        label.text = "视频"
        playerView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.center.equalTo(playerView)
        }
        playerView.delegate = self
        playerView.backBlock = { [unowned self] (isFullScreen) in
            if isFullScreen {
                return
            } else {
                let _ = self.navigationController?.popViewController(animated: true)
            }
        }

        let url = URL(string: "http://wvideo.spriteapp.cn/video/2016/0328/56f8ec01d9bfe_wpd.mp4")!
        let asset = BMPlayerResource(url: url,
                                     name: "风格互换：原来你我相爱")
        playerView.setVideo(resource: asset)
//        playerView.seek(30)
//        playerView.setVideo(resource: BMPlayerResource(url: url))
    }
}

extension DHVedioVC: BMPlayerDelegate {
    // Call when player orinet changed
    func bmPlayer(player: BMPlayer, playerOrientChanged isFullscreen: Bool) {
        if !isFullscreen {
            UIView.animate(withDuration: 0.25, animations: {
                self.playerView.transform = self.playerView.transform.rotated(by: CGFloat(-Double.pi / 2.0))
            })
            UIApplication.shared.setStatusBarHidden(false, with: .fade)
            UIApplication.shared.statusBarOrientation = .portrait

            view.addSubview(playerView)
            playerView.snp.remakeConstraints({ (make) in
                make.top.left.right.equalToSuperview()
                make.height.equalTo(200)
            })
        }
    }

    // Call back when playing state changed, use to detect is playing or not
    func bmPlayer(player: BMPlayer, playerIsPlaying playing: Bool) {
        print("| BMPlayerDelegate | playerIsPlaying | playing - \(playing)")
    }

    // Call back when playing state changed, use to detect specefic state like buffering, bufferfinished
    func bmPlayer(player: BMPlayer, playerStateDidChange state: BMPlayerState) {
        print("| BMPlayerDelegate | playerStateDidChange | state - \(state)")
    }

    // Call back when play time change
    func bmPlayer(player: BMPlayer, playTimeDidChange currentTime: TimeInterval, totalTime: TimeInterval) {
        //        print("| BMPlayerDelegate | playTimeDidChange | \(currentTime) of \(totalTime)")
    }

    // Call back when the video loaded duration changed
    func bmPlayer(player: BMPlayer, loadedTimeDidChange loadedDuration: TimeInterval, totalDuration: TimeInterval) {
        //        print("| BMPlayerDelegate | loadedTimeDidChange | \(loadedDuration) of \(totalDuration)")
    }
}
