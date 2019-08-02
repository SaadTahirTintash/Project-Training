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

    //MARK:- Outlets
    @IBOutlet weak var titleLabel               : UILabel!
    @IBOutlet weak var videoView                : YTPlayerView!
    @IBOutlet weak var activityIndicator        : UIActivityIndicatorView!
    
    //MARK:- Public Properties
    var shareBtnPressed                         : ((FCNewsFeedDetailVM?)->Void)?
    var viewModel                               : FCNewsFeedDetailVM?
    
    //MARK:- Class Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        videoView.delegate = self        
    }
}

//MARK:- Extension
extension FCVideoTableViewCell {
    
    //MARK:- Button Action
    @IBAction func share(_ sender: Any) {
        shareBtnPressed?(viewModel)
    }
}

//MARK:- Extension
extension FCVideoTableViewCell {
    
    //MARK:- Methods
    /// sets uiview from view model and loading video using given link
    func configure() {
        titleLabel.text     = viewModel?.title
        if let urlString    = viewModel?.url {
            activityIndicator.startAnimating()
            videoView.load(withVideoId: urlString, playerVars:["playsinline":1])            
        }
    }
}

//MARK:- Youtube Player Delegate
extension FCVideoTableViewCell: YTPlayerViewDelegate {
    
    //MARK:- Methods
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
