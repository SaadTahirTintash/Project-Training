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
extension FCVideoTableViewCell{
    func configure(){
        titleLabel.text = viewModel?.title
        if let urlString = viewModel?.url{
            //Code review: you need to call startAnimating method of activityIndicator (you can also startAnimating in prepareforReuse method of this cell)
            videoView.load(withVideoId: urlString, playerVars:["playsinline":1])      
        }
    }
    @IBAction func share(_ sender: Any) {
        shareBtnPressed?(viewModel)
    }
}
extension FCVideoTableViewCell: YTPlayerViewDelegate{
    func playerViewPreferredInitialLoading(_ playerView: YTPlayerView) -> UIView? {
        let videoPreferredView              = UIView(frame: playerView.frame)
        videoPreferredView.backgroundColor  = .black
        return videoPreferredView
    }
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        print("Video is ready")
        activityIndicator.stopAnimating()
    }
}
