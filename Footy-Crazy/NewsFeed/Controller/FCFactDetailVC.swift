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
        } else if let url = URL(string: urlString){
            imgView.loadImage(from: url, success: { [weak self](img) in
                self?.success(img,urlString)
            }) { [weak self](errorMsg) in
                self?.failure(errorMsg)
            }
        }
    }
    func success(_ img: UIImage,_ urlString: String){
        FCCacheManager.shared.setImage(urlString, img)
        activityIndicator.stopAnimating()
    }
    func failure(_ errorMsg: String){
        activityIndicator.stopAnimating()
        print(errorMsg)
    }
}
