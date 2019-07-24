//
//  FCGalleryCell.swift
//  Footy-Crazy
//
//  Created by Tintash on 11/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCGalleryCell: UICollectionViewCell, FCImageDownloader {
    @IBOutlet weak var img                  : UIImageView!
    @IBOutlet weak var activityIndicator    : UIActivityIndicatorView!
    var viewModel                           : FCGalleryDetailVM?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configure(){
        loadImage(from: viewModel?.imageUrl, success: { [weak self](downloadedImg, urlString) in
            guard urlString == self?.viewModel?.imageUrl else{
                print("Wrong cell!")
                return
            }
            DispatchQueue.main.async {
                self?.success(downloadedImg, urlString)
            }
        }) { [weak self](errorMsg) in
            DispatchQueue.main.async {
                self?.failure(errorMsg)
            }
        }
    }
    func success(_ downloadedImg: UIImage,_ urlString: String){
        activityIndicator.stopAnimating()
        img.image = downloadedImg
    }
    
    func failure(_ errorMsg: String){        
        activityIndicator.stopAnimating()
        img.image = FCConstants.EMPTY_IMAGE
        print(errorMsg)
    }
    override func prepareForReuse() {
        img.image = nil
    }
}
