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
        if let response = FCCacheManager.shared.getNewsLink(newsLink){
            print("News Link loaded from Cache")
            titleLbl.text = response.title
            if let urlString = response.image{
                loadImage(urlString)
            }
        }else{
            let slp: SwiftLinkPreview = SwiftLinkPreview()
            activityIndicator.startAnimating()
            slp.preview(newsLink, onSuccess: { [weak self] (response) in
                FCCacheManager.shared.setNewsLink(newsLink, response)
                self?.titleLbl.text = response.title
                guard let urlString = response.image else{
                    print("Incorrect image url!")
                    return
                }
                self?.loadImage(urlString)
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    func loadImage(_ urlString: String){
        if let cache = FCCacheManager.shared.getImage(urlString){
            newsImg.image = cache
            print("Image loaded from cache")
            activityIndicator.stopAnimating()
        }else{
            FCUtilities.shared.loadImage(from: urlString, success: {[weak self] (downloadedImg) in
                FCCacheManager.shared.setImage(urlString, downloadedImg)
                self?.activityIndicator.stopAnimating()
                self?.newsImg.image = downloadedImg
                }, failure: {[weak self](errorMsg) in
                    print(errorMsg)
                    self?.newsImg.image = FCConstants.EMPTY_IMAGE
                    self?.activityIndicator.stopAnimating()
            })
        }
    }
}


