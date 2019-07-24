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
        loadImage(from: viewModel?.imageUrl, success: success, failure: failure)
    }
    func success(_ downloadedImg: UIImage,_ urlString: String){
        DispatchQueue.main.async {[weak self] in
            self?.activityIndicator.stopAnimating()
            self?.img.image = downloadedImg
        }
    }
    func failure(_ errorMsg: String){
        DispatchQueue.main.async {[weak self] in
            self?.activityIndicator.stopAnimating()
            self?.img.image = FCConstants.EMPTY_IMAGE
        }
        print(errorMsg)
    }
}

extension FCGalleryDetailVC: FCUtilities{
    
    @IBAction func share(_ sender: Any?){
        if let downloadedImage = img.image{
            let shareableImg = [downloadedImage]
            shareContent(self, shareableImg)
        }
    }
}
