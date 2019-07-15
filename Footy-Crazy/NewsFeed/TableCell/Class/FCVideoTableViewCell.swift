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
//    @IBOutlet weak var descriptionLabel: UILabel!
    weak var shareBtnDelegate: FCNewsFeedShareButtonDelegate?
    var newsFeedModel: FCNewsFeedModel = FCNewsFeedModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        videoView.delegate = self        
    }
    
    func setupCell(_ model: FCNewsFeedModel){        
        titleLabel.text = model.title
//        descriptionLabel.text = model.description
        if let urlString = model.url{
            videoView.load(withVideoId: urlString, playerVars:["playsinline":1])
        }        
        saveModel(model)
    }
    
    func saveModel(_ model: FCNewsFeedModel){
        newsFeedModel.title = model.title
        newsFeedModel.url = model.url
//        newsFeedModel.description = model.description
    }
    
    @IBAction func share(_ sender: Any) {
        shareBtnDelegate?.didPressShareButton(newsFeedModel)
    }
}

extension FCVideoTableViewCell: YTPlayerViewDelegate{
    
    func addActivityIndicator(_ to: UIView){
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.center = to.center
        to.addSubview(activityIndicator)
        to.layoutIfNeeded()
        activityIndicator.startAnimating()
    }
    
    func playerViewPreferredInitialLoading(_ playerView: YTPlayerView) -> UIView? {
        let videoPreferredView = UIView.init(frame: playerView.frame)
        videoPreferredView.backgroundColor = .black
        //addActivityIndicator(videoPreferredView)
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
