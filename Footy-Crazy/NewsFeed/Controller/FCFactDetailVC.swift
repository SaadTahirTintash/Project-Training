//
//  FCNewsFeedDetailVC.swift
//  Footy-Crazy
//
//  Created by Tintash on 09/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit
class FCFactDetailVC: UIViewController {
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
        if let urlString = viewModel?.url{
            loadImage(urlString)
        }        
    }
    func loadImage(_ urlString: String){
        if let cache = FCCacheManager.shared.getImage(urlString){
            imgView.image = cache
            print("Image loaded from cache")
            activityIndicator.stopAnimating()
        }else{
            FCUtilities.shared.loadImage(from: urlString, success: {[weak self] (downloadedImg) in
                FCCacheManager.shared.setImage(urlString, downloadedImg)
                self?.activityIndicator.stopAnimating()
                self?.imgView.image = downloadedImg
            }, failure: {[weak self](errorMsg) in
                    print(errorMsg)
                    self?.activityIndicator.stopAnimating()
            })
        }
    }
}
