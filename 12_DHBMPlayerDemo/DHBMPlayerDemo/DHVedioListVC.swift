//
//  DHVedioListVC.swift
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

class DHVedioListVC: UIViewController {
    var playerView: BMPlayer!
    @IBOutlet weak var tableView: UITableView!
    weak var currentCell: UITableViewCell?
    var currentIndexPath: IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        BMPlayerConf.allowLog = false
        BMPlayerConf.shouldAutoPlay = true
        BMPlayerConf.tintColor = UIColor.white
        BMPlayerConf.topBarShowInCase = .always
        BMPlayerConf.loaderType = NVActivityIndicatorType.ballRotateChase
        BMPlayerConf.topBarShowInCase = .horizantalOnly
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if playerView != nil {
            playerView.removeFromSuperview()
            playerView = nil
        }
    }
}

extension DHVedioListVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DHVedioListTableViewCell", for: indexPath) as! DHVedioListTableViewCell
        cell.playBtnClickedBlock = {
            self.currentCell = cell
            self.currentIndexPath = indexPath
            if self.playerView != nil {
                self.playerView.removeFromSuperview()
            }
            self.playerView = BMPlayer()
            cell.contentView.addSubview(self.playerView)
            self.playerView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            self.playerView.delegate = self
            self.playerView.backBlock = { [unowned self] (isFullScreen) in
                if isFullScreen {
                    return
                } else {
                    let _ = self.navigationController?.popViewController(animated: true)
                }
            }
            let url = URL(string: "http://wvideo.spriteapp.cn/video/2016/0328/56f8ec01d9bfe_wpd.mp4")!
            self.playerView.seek(30)
            self.playerView.setVideo(resource: BMPlayerResource(url: url))
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if currentIndexPath != nil {
            let rect = tableView.rectForRow(at: currentIndexPath!)
            let rectInSuperView = tableView.convert(rect, to: view)
            print(rectInSuperView)
            if rectInSuperView.maxY < 0 || rectInSuperView.minY > view.bounds.height {
                playerView.removeFromSuperview()
                playerView = nil
                currentCell = nil
                currentIndexPath = nil
            }
        }
    }

}

extension DHVedioListVC: BMPlayerDelegate {
    // Call when player orinet changed
    func bmPlayer(player: BMPlayer, playerOrientChanged isFullscreen: Bool) {
        if !isFullscreen {
            UIView.animate(withDuration: 0.25, animations: {
                self.playerView.transform = self.playerView.transform.rotated(by: CGFloat(-Double.pi / 2.0))
            })
            UIApplication.shared.setStatusBarHidden(false, with: .fade)
            UIApplication.shared.statusBarOrientation = .portrait

            currentCell?.addSubview(playerView)
            playerView.snp.remakeConstraints({ (make) in
                make.edges.equalToSuperview()
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
