//
//  FCVideoDetailVC.swift
//  Footy-Crazy
//
//  Created by Tintash on 10/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class FCVideoDetailVC: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var activityIndicator    : UIActivityIndicatorView!
    @IBOutlet weak var titleLabel           : UILabel!
    @IBOutlet weak var descriptionLabel     : UILabel!
    @IBOutlet weak var videoView            : YTPlayerView!
    
    //MARK:- Public Properties
    var viewModel                           : FCNewsFeedDetailVM?
    
    //MARK:- Class Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        videoView.delegate = self
        setupVC()
    }
}

extension FCVideoDetailVC {
    
    func setupVC(){
        descriptionLabel.text = viewModel?.description
        titleLabel.text = viewModel?.title
        if let urlString = viewModel?.url {            
            videoView.load(withVideoId: urlString, playerVars:["playsinline":1])
        }        
    }
}

//MARK:- Youtube Player Delegate
extension FCVideoDetailVC: YTPlayerViewDelegate {
    
    func playerViewPreferredInitialLoading(_ playerView: YTPlayerView) -> UIView? {
        let videoPreferredView = UIView.init(frame: playerView.frame)
        videoPreferredView.backgroundColor = .black
        return videoPreferredView
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        activityIndicator.stopAnimating()
    }
}
