//
//  FCFactTableViewCell.swift
//  Footy-Crazy
//
//  Created by Tintash on 01/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCFactTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    weak var shareBtnDelegate: FCNewsFeedShareButtonDelegate?
    var viewModel: FCNewsFeedDetailVM?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(){
        titleLabel.text = viewModel?.title
        if let urlString = viewModel?.url{
            if let url = URL(string: urlString){
                imgView.loadImage(from: url){[weak self](_,_) in
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    @IBAction func share(_ sender: Any) {
        shareBtnDelegate?.didPressShareButton(viewModel)
    }
    
    override func prepareForReuse() {
        self.imgView.image = nil
    }
    
}
