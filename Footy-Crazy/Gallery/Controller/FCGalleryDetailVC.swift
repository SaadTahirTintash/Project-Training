//
//  FCGalleryImageDetailVC.swift
//  Footy-Crazy
//
//  Created by Tintash on 11/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit
class FCGalleryDetailVC: UIViewController {
    @IBOutlet weak var img                  : UIImageView!
    @IBOutlet weak var activityIndicator    : UIActivityIndicatorView!
    var viewModel                           : FCGalleryDetailVM?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
}

extension FCGalleryDetailVC{
    func setupVC(){
        if let urlString = viewModel?.imageUrl{
            loadImage(urlString)
        }
    }
    @IBAction func share(_ sender: Any?){
        if let downloadedImage = img.image{
            let shareableImg = [downloadedImage]
            //Code Review: instead of using Shared instance methode move this function in protocol extension
            FCUtilities.shared.shareContent(self, shareableImg)
        }
    }
    //Code review:  move image loading functionality in protocol extension as same functionality is using in many places
    func loadImage(_ urlString: String){
        if let cache = FCCacheManager.shared.getImage(urlString){
            img.image = cache
            print("Image loaded from cache")
            activityIndicator.stopAnimating()
        }else{
            FCUtilities.shared.loadImage(from: urlString, success: {[weak self] (downloadedImg) in
                FCCacheManager.shared.setImage(urlString, downloadedImg)
                self?.activityIndicator.stopAnimating()
                self?.img.image = downloadedImg
                }, failure: {[weak self](errorMsg) in
                    print(errorMsg)
                    self?.activityIndicator.stopAnimating()
            })
        }
    }
}
