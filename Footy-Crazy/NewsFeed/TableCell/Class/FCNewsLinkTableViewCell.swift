//
//  FCNewsLinkTableViewCell.swift
//  Footy-Crazy
//
//  Created by Tintash on 01/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit
import SwiftLinkPreview
class FCNewsLinkTableViewCell: UITableViewCell {
    @IBOutlet weak var activityIndicator    : UIActivityIndicatorView!
    @IBOutlet weak var titleLbl             : UILabel!
    @IBOutlet weak var newsImg              : UIImageView!
    @IBOutlet weak var stackView            : UIStackView!
    weak var shareBtnDelegate               : FCNewsFeedShareButtonDelegate?
    var viewModel                           : FCNewsFeedDetailVM?
    let slp                                 : SwiftLinkPreview                  = SwiftLinkPreview()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func prepareForReuse() {
        newsImg.image = nil
    }
    func configure() {
        titleLbl.text   = viewModel?.title
        if let urlString = viewModel?.url{
            loadLink(urlString)
        }
    }
    @IBAction func share(_ sender: Any) {
        shareBtnDelegate?.didPressShareButton(viewModel)
    }    
    func loadLink(_ newsLink: String){
        slp.preview(newsLink, onSuccess: { [weak self] (response) in
            self?.titleLbl.text   = response.title
            if let imgURL = response.image{
                if let url = URL(string: imgURL){
                    self?.newsImg.loadImage(from: url){[weak self](_,_) in
                        self?.activityIndicator.stopAnimating()
                    }
                }
            } else{
                self?.newsImg.image = Constants.EMPTY_IMAGE
            }
        }) { [weak self](error) in
            self?.newsImg.image = Constants.EMPTY_IMAGE
        }
    }
}


