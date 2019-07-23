//
//  FCFactTableViewCell.swift
//  Footy-Crazy
//
//  Created by Tintash on 01/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit
class FCFactTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel           : UILabel!
    @IBOutlet weak var imgView              : UIImageView!
    @IBOutlet weak var activityIndicator    : UIActivityIndicatorView!
    var shareBtnPressed                     : ((FCNewsFeedDetailVM?)->Void)?
    var viewModel                           : FCNewsFeedDetailVM?
}

extension FCFactTableViewCell{
    func configure(){
        titleLabel.text = viewModel?.title
    }
    func setImage(_ newImage: UIImage){
        activityIndicator.stopAnimating()
        imgView.image = newImage
    }
    @IBAction func share(_ sender: Any) {
        shareBtnPressed?(viewModel)
    }
    override func prepareForReuse() {
        self.imgView.image = nil
    }
}
