//
//  FCFactTableViewCell.swift
//  Footy-Crazy
//
//  Created by Tintash on 01/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit
class FCFactTableViewCell: UITableViewCell, FCNewsFeedCellProtocol {
    @IBOutlet weak var titleLabel           : UILabel!
    @IBOutlet weak var imgView              : UIImageView!
    @IBOutlet weak var activityIndicator    : UIActivityIndicatorView!
    var shareBtnPressed                     : ((FCNewsFeedDetailVM?)->Void)?
    var viewModel                           : FCNewsFeedDetailVM?
}

extension FCFactTableViewCell: FCImageDownloader{
    func configure(){
        titleLabel.text = viewModel?.title
        activityIndicator.startAnimating()
        loadImage(from: viewModel?.url, success: {[weak self] (downloadedImg,urlString) in
            guard urlString == self?.viewModel?.url else{
                print("Wrong cell!")
                return
            }
            self?.success(self?.imgView, self?.activityIndicator, downloadedImg)
            }, failure: {[weak self](errorMsg) in
                self?.failure(self?.imgView,self?.activityIndicator, errorMsg)
        })
    }
    
    @IBAction func share(_ sender: Any) {
        shareBtnPressed?(viewModel)
    }
    override func prepareForReuse() {
        self.imgView.image = nil
    }
}
