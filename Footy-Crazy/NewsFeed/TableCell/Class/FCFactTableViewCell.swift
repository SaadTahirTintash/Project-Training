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
    var shareBtnPressed                     : ((FCNewsFeedDetailVM?)->Void)?
    var viewModel                           : FCNewsFeedDetailVM?
}

extension FCFactTableViewCell{
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
        } else if let url = URL(string: urlString) {
            imgView.loadImage(from: url, success: { [weak self](img) in
                FCCacheManager.shared.setImage(urlString, img)
                self?.activityIndicator.stopAnimating()
            }) { [weak self](errorMsg) in
                self?.activityIndicator.stopAnimating()
                print(errorMsg)
            }
        }
    }
    @IBAction func share(_ sender: Any) {
        shareBtnPressed?(viewModel)
    }
    override func prepareForReuse() {
        self.imgView.image = nil
    }
}
