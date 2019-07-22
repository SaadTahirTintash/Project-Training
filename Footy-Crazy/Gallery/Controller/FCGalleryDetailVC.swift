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
            FCUtilities.shared.shareContent(self, shareableImg)
        }
    }
    func loadImage(_ urlString: String){
        if let cache = FCCacheManager.shared.getImage(urlString){
            img.image = cache
            print("Image loaded from cache")
            activityIndicator.stopAnimating()
        } else if let url = URL(string: urlString){
            img.loadImage(from: url, success: { [weak self](img) in
                FCCacheManager.shared.setImage(urlString, img)
                self?.activityIndicator.stopAnimating()
            }) { [weak self](errorMsg) in
                self?.activityIndicator.stopAnimating()
                print(errorMsg)
            }
        }
    }
}
