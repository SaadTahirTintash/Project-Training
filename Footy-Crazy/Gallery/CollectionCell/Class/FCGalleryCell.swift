//
//  FCGalleryCell.swift
//  Footy-Crazy
//
//  Created by Tintash on 11/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCGalleryCell: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(_ model: FCGalleryModel){
        if let urlString = model.imageUrl{
            if let url = URL(string: urlString){
                img.loadImage(from: url){
                    [weak self](_,_) in
                    self?.activityIndicator.stopAnimating()
                }
            }
        }        
    }    
}
