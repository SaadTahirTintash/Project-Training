//
//  FCNewsLinkDetailVC.swift
//  Footy-Crazy
//
//  Created by Tintash on 10/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit
import SwiftLinkPreview
class FCNewsLinkDetailVC: UIViewController {
    @IBOutlet weak var activityIndicator        : UIActivityIndicatorView!
    @IBOutlet weak var titleLabel               : UILabel!
    @IBOutlet weak var descriptionLabel         : UILabel!
    @IBOutlet weak var urlButton                : UIButton!
    @IBOutlet weak var imgView                  : UIImageView!
    var viewModel                               : FCNewsFeedDetailVM?
}
extension FCNewsLinkDetailVC{
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    func setupVC(){
        titleLabel.text         = viewModel?.title
        descriptionLabel.text   = viewModel?.description
        urlButton.setTitle(viewModel?.url, for: .normal)
        guard let urlString     = viewModel?.url else {
            print("Incorrect URL")
            return
        }
        loadLink(urlString)
    }
    @IBAction func urlButtonAction(_ sender: Any) {
        if let urlString = viewModel?.url {
            FCUtilities.shared.openLinkInSafari(urlString, self.navigationController)
        }
    }
    func loadLink(_ newsLink: String){
        if let response = FCCacheManager.shared.getNewsLink(newsLink){
            linkSuccess(response, newsLink)
        }else{
            let slp : SwiftLinkPreview = SwiftLinkPreview()
            slp.preview(newsLink, onSuccess: { [weak self] (response) in
                FCCacheManager.shared.setNewsLink(newsLink, response)
                self?.linkSuccess(response, newsLink)
            }) { [weak self](error) in
                self?.linkFailure(error)
            }
        }
    }
    func linkSuccess(_ response: Response, _ urlString: String){
        titleLabel.text     = response.title
        urlButton.setTitle(response.url?.absoluteString, for: .normal)
        descriptionLabel.text = response.description
        if let urlString    = response.image{
            loadImage(urlString)
        }
    }
    func linkFailure(_ error: PreviewError){
        imgView.image = FCConstants.EMPTY_IMAGE
        print(error.localizedDescription)
    }
    func loadImage(_ urlString: String){
        if let cache = FCCacheManager.shared.getImage(urlString){
            imgView.image = cache
            print("Image loaded from cache")
            activityIndicator.stopAnimating()
        }else{
            FCUtilities.shared.loadImage(from: urlString, success: {[weak self] (downloadedImg) in
                FCCacheManager.shared.setImage(urlString, downloadedImg)
                self?.activityIndicator.stopAnimating()
                self?.imgView.image = downloadedImg
                }, failure: {[weak self](errorMsg) in
                    print(errorMsg)
                    self?.activityIndicator.stopAnimating()
            })
        }
    }
}
