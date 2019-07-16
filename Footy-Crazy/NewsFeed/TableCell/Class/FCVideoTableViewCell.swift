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

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var videoView: YTPlayerView!
    weak var shareBtnDelegate: FCNewsFeedShareButtonDelegate?
    var viewModel: FCNewsFeedDetailVM?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        videoView.delegate = self        
    }
    
    func configure(){        
        titleLabel.text = viewModel?.title
        if let urlString = viewModel?.url{
            videoView.load(withVideoId: urlString, playerVars:["playsinline":1])            
        }
    }
    
    @IBAction func share(_ sender: Any) {
        shareBtnDelegate?.didPressShareButton(viewModel)
    }
}

extension FCVideoTableViewCell: YTPlayerViewDelegate{
    
    func playerViewPreferredInitialLoading(_ playerView: YTPlayerView) -> UIView? {
        let videoPreferredView = UIView.init(frame: playerView.frame)
        videoPreferredView.backgroundColor = .black
        return videoPreferredView
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        print("Video is ready")
        activityIndicator.stopAnimating()
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
