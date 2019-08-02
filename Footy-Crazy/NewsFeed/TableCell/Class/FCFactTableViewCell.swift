//
//  FCFactTableViewCell.swift
//  Footy-Crazy
//
//  Created by Tintash on 01/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCFactTableViewCell: UITableViewCell, FCNewsFeedCellProtocol {
    
    //MARK:- Outlets
    @IBOutlet weak var titleLabel           : UILabel!
    @IBOutlet weak var imgView              : UIImageView!
    @IBOutlet weak var activityIndicator    : UIActivityIndicatorView!
    
    //MARK:- Public Properties
    var shareBtnPressed                     : ((FCNewsFeedDetailVM?)->Void)?
    var viewModel                           : FCNewsFeedDetailVM?
    
    //MARK:- Class Methods
    override func prepareForReuse() {
        self.imgView.image = nil
    }
}

//MARK:- Extension
extension FCFactTableViewCell {
    
    //MARK:- Button Action
    @IBAction func share(_ sender: Any) {
        shareBtnPressed?(viewModel)
    }
}

//MARK:- Image Downloading Protocol
extension FCFactTableViewCell: FCImageDownloader {
    
    //MARK:- Methods
    /// sets the uiview using view model and loading image from the given link
    func configure() {
        titleLabel.text = viewModel?.title
        activityIndicator.startAnimating()
        loadImage(from: viewModel?.url, success: { [weak self] (downloadedImg,urlString) in
                guard urlString == self?.viewModel?.url else{
                    print(FCConstants.ERRORS.wrongCell)
                    return
                }
                self?.success(self?.imgView, self?.activityIndicator, downloadedImg)
            }, failure: {[weak self](errorMsg) in
                self?.failure(self?.imgView,self?.activityIndicator, errorMsg)
        })
    }
}
