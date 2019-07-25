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

extension FCGalleryDetailVC: FCImageDownloader{
    func setupVC(){
        loadImage(from: viewModel?.imageUrl, success: { [weak self] (downloadedImg, urlString) in
            self?.success(self?.img, self?.activityIndicator, downloadedImg)
        }) { [weak self] (errorMsg) in
            self?.failure(self?.img, self?.activityIndicator, errorMsg)
        }
    }
}

extension FCGalleryDetailVC: FCShareContent{
    
    @IBAction func share(_ sender: Any?){
        if let downloadedImage = img.image{
            let shareableImg = [downloadedImage]
            shareContent(self, shareableImg)
        }
    }
}
