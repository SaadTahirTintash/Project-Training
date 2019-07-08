//
//  FCVideoTableViewCell.swift
//  Footy-Crazy
//
//  Created by Tintash on 28/06/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class FCVideoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var videoView: YTPlayerView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        videoView.delegate = self        
    }
    
    func addActivityIndicator(_ to: UIView){
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.center = CGPoint(x: to.frame.width/2, y: to.frame.height/2)
        to.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
}

extension FCVideoTableViewCell: YTPlayerViewDelegate{
    
    func playerViewPreferredInitialLoading(_ playerView: YTPlayerView) -> UIView? {
        let videoPreferredView = UIView.init(frame: videoView.frame)
        videoPreferredView.backgroundColor = .black
        addActivityIndicator(videoPreferredView)
        return videoPreferredView
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        print("Video is ready")
    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        switch state {
        case .buffering:
            print("Video is bufferring")
        case .ended:
            print("Video is ended")
        case .paused:
            print("Video is paused")
        case .playing:
            print("Video is playing")
        case .unstarted:
            print("Video is unstarted")
        case .queued:
            print("Video is queued")
        default:
            print("Video is unknown")

        }
    }
}
