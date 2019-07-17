//
//  FCFactTableViewCell.swift
//  Footy-Crazy
//
//  Created by Tintash on 01/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit
class FCFactTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel           : UILabel!
    @IBOutlet weak var imgView              : UIImageView!
    @IBOutlet weak var activityIndicator    : UIActivityIndicatorView!
    weak var shareBtnDelegate               : FCNewsFeedShareButtonDelegate?
    var viewModel                           : FCNewsFeedDetailVM?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configure(){
        titleLabel.text = viewModel?.title
        if let urlString = viewModel?.url{
            loadImage(urlString)
        }
    }
    func loadImage(_ urlString: String){
        if let cache = FCCacheManager.shared.getImage(urlString){
            imgView.image = cache
            print("Image loaded from cache")
            activityIndicator.stopAnimating()
        } else if let url = URL(string: urlString){
            imgView.loadImage(from: url){[weak self](success,downloadedImg) in
                if success{
                    print("Image downloaded from internet")
                    if let downloadedImg = downloadedImg{                        
                        FCCacheManager.shared.setImage(urlString, downloadedImg)
                    }
                }
                self?.activityIndicator.stopAnimating()
            }
        }
    }
    @IBAction func share(_ sender: Any) {
        shareBtnDelegate?.didPressShareButton(viewModel)
    }
    override func prepareForReuse() {
        self.imgView.image = nil
    }
}
