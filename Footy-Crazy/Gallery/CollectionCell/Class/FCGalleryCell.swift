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
            if let url = URL(string: urlString){
                img.loadImage(from: url){
                    [weak self](_,_) in
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
    }    
}
