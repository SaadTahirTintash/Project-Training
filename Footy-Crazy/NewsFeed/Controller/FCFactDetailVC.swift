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
        loadImage(from: viewModel?.url, success: success, failure: failure)
    }
    func success(_ downloadedImg: UIImage,_ urlString: String){
        DispatchQueue.main.async {[weak self] in
            self?.activityIndicator.stopAnimating()
            self?.imgView.image = downloadedImg
        }
    }
    func failure(_ errorMsg: String){
        DispatchQueue.main.async {[weak self] in
            self?.activityIndicator.stopAnimating()
            self?.imgView.image = FCConstants.EMPTY_IMAGE
        }
        print(errorMsg)
    }
}
