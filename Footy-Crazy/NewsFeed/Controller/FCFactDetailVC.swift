//
//  FCNewsFeedDetailVC.swift
//  Footy-Crazy
//
//  Created by Tintash on 09/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit
class FCFactDetailVC: UIViewController, FCImageDownloader {
    @IBOutlet weak var activityIndicator    : UIActivityIndicatorView!
    @IBOutlet weak var titleLabel           : UILabel!
    @IBOutlet weak var descriptionLabel     : UILabel!
    @IBOutlet weak var imgView              : UIImageView!
    var viewModel                           : FCNewsFeedDetailVM?
}
extension FCFactDetailVC{
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    func setupVC(){
        descriptionLabel.text = viewModel?.description
        titleLabel.text = viewModel?.title
        loadImage(from: viewModel?.url, success: { [weak self] (downloadedImg, urlString) in
            self?.success(self?.imgView, self?.activityIndicator, downloadedImg)
        }) { [weak self] (errorMsg) in
            self?.failure(self?.imgView, self?.activityIndicator, errorMsg)
        }
    }
}
