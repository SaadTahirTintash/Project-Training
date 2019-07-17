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
    func configure(){
        if let urlString = viewModel?.imageUrl{
            loadImage(urlString)
        }
    }
    func loadImage(_ urlString: String){
        if let cache = FCCacheManager.shared.getImage(urlString){
            img.image = cache
            print("Image loaded from cache")
            activityIndicator.stopAnimating()
        } else if let url = URL(string: urlString){
            img.loadImage(from: url){[weak self](success,downloadedImg) in
                if success{
                    print("Image downloaded from internet")
                    if let downloadedImg = downloadedImg{
                        FCCacheManager.shared.setImage(urlString, downloadedImg)
                    }
                }
                self?.activityIndicator.stopAnimating()
            }
        }
    }
    override func prepareForReuse() {
        img.image = nil
    }
}
