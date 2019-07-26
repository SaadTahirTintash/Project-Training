//
//  FCGalleryCell.swift
//  Footy-Crazy
//
//  Created by Tintash on 11/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCGalleryCell: UICollectionViewCell {
    
    @IBOutlet weak var img                  : UIImageView!
    @IBOutlet weak var activityIndicator    : UIActivityIndicatorView!
    
    var viewModel                           : FCGalleryDetailVM?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        img.image = nil
    }
}

extension FCGalleryCell: FCImageDownloader {
    
    func configure(){
        activityIndicator.startAnimating()
        loadImage(from: viewModel?.imageUrl, success: { [weak self](downloadedImg, urlString) in
            guard urlString == self?.viewModel?.imageUrl else{
                print(FCConstants.ERRORS.wrongCell)
                return
            }
            self?.success(self?.img, self?.activityIndicator, downloadedImg)
        }) { [weak self](errorMsg) in
            self?.failure(self?.img, self?.activityIndicator, errorMsg)
        }
    }
}
