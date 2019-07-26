//
//  FCVideoTableViewCell.swift
//  Footy-Crazy
//
//  Created by Tintash on 28/06/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class FCVideoTableViewCell: UITableViewCell, FCNewsFeedCellProtocol {
    
    @IBOutlet weak var titleLabel               : UILabel!
    @IBOutlet weak var videoView                : YTPlayerView!
    @IBOutlet weak var activityIndicator        : UIActivityIndicatorView!
    
    var shareBtnPressed                         : ((FCNewsFeedDetailVM?)->Void)?
    var viewModel                               : FCNewsFeedDetailVM?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        videoView.delegate = self        
    }
}

extension FCVideoTableViewCell {
    
    @IBAction func share(_ sender: Any) {
        shareBtnPressed?(viewModel)
    }
}

extension FCVideoTableViewCell {
    
    /// sets uiview from view model and loading video using given link
    func configure() {
        titleLabel.text     = viewModel?.title
        if let urlString    = viewModel?.url {
            activityIndicator.startAnimating()
            videoView.load(withVideoId: urlString, playerVars:["playsinline":1])            
        }
    }
}

extension FCVideoTableViewCell: YTPlayerViewDelegate {
    
    /// Used to create an initial view for youtube player
    ///
    /// - Parameter playerView: youtube player view
    /// - Returns: initial view
    func playerViewPreferredInitialLoading(_ playerView: YTPlayerView) -> UIView? {
        let videoPreferredView              = UIView(frame: playerView.frame)
        videoPreferredView.backgroundColor  = .black
        return videoPreferredView
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        activityIndicator.stopAnimating()
    }
}
