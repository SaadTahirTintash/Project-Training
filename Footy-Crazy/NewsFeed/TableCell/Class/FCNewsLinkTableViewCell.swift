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
    var shareBtnPressed                     : ((FCNewsFeedDetailVM?)->Void)?
    var viewModel                           : FCNewsFeedDetailVM?
}
extension FCNewsLinkTableViewCell{
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
        shareBtnPressed?(viewModel)
    }    
    func loadLink(_ newsLink: String){
        let slp: SwiftLinkPreview = SwiftLinkPreview()
        slp.preview(newsLink, onSuccess: { [weak self] (response) in
            self?.titleLbl.text = response.title
            if let urlString = response.image{
                self?.loadImage(urlString)
            } else{
                self?.newsImg.image = FCConstants.EMPTY_IMAGE
            }
        }) { [weak self](error) in
            self?.newsImg.image = FCConstants.EMPTY_IMAGE
        }
    }
    func loadImage(_ urlString: String){
        if let cache = FCCacheManager.shared.getImage(urlString){
            newsImg.image = cache
            print("Image loaded from cache")
            activityIndicator.stopAnimating()
        } else if let url = URL(string: urlString){
            newsImg.loadImage(from: url, success: { [weak self](img) in
                FCCacheManager.shared.setImage(urlString, img)
                self?.activityIndicator.stopAnimating()
            }, failure:  { [weak self](msg) in
                self?.activityIndicator.stopAnimating()
                print(msg)
            })
        }
    }
}


