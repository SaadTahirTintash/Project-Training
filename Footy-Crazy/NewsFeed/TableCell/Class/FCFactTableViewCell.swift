//
//  FCFactTableViewCell.swift
//  Footy-Crazy
//
//  Created by Tintash on 01/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit
class FCFactTableViewCell: UITableViewCell, FCImageDownloader {
    @IBOutlet weak var titleLabel           : UILabel!
    @IBOutlet weak var imgView              : UIImageView!
    @IBOutlet weak var activityIndicator    : UIActivityIndicatorView!
    var shareBtnPressed                     : ((FCNewsFeedDetailVM?)->Void)?
    var viewModel                           : FCNewsFeedDetailVM?
}

extension FCFactTableViewCell{
    func configure(){
        titleLabel.text = viewModel?.title
        activityIndicator.startAnimating()
        loadImage(from: viewModel?.url, success: {[weak self](downloadedImg,urlString) in
                guard urlString == self?.viewModel?.url else{
                    print("Wrong cell!")
                    return
                }
                DispatchQueue.main.async {
                    self?.success(downloadedImg)
                }
            }, failure: {[weak self](errorMsg) in
                DispatchQueue.main.async {
                    self?.failure(errorMsg)
                }
        })
    }
    func success(_ downloadedImg: UIImage){
        activityIndicator.stopAnimating()
        imgView.image = downloadedImg
    }
    func failure(_ errorMsg: String){
        activityIndicator.stopAnimating()
        print(errorMsg)
    }
    @IBAction func share(_ sender: Any) {
        shareBtnPressed?(viewModel)
    }
    override func prepareForReuse() {
        self.imgView.image = nil
    }
}
