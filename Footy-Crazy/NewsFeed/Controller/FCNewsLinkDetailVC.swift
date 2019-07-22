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
        descriptionLabel.text = viewModel?.description
        titleLabel.text = viewModel?.title
        urlButton.setTitle(viewModel?.url, for: .normal)
        guard let urlString = viewModel?.url else{
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
        let slp : SwiftLinkPreview = SwiftLinkPreview()
        slp.preview(newsLink, onSuccess: { [weak self] (response) in
            self?.linkSuccess(response, newsLink)
        }) { [weak self](error) in
            self?.linkFailure(error)
        }
    }
    func linkSuccess(_ response: Response, _ urlString: String){
        titleLabel.text   = response.title
        urlButton.setTitle(response.url?.absoluteString, for: .normal)
        descriptionLabel.text = response.description
        if let urlString = response.image{
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
        } else if let url = URL(string: urlString){
            imgView.loadImage(from: url, success: { [weak self](img) in
                self?.imageSuccess(img, urlString)
            }) { [weak self](errorMsg) in
                self?.imageFailure(errorMsg)
            }
        }
    }
    func imageSuccess(_ img: UIImage, _ urlString: String){
        FCCacheManager.shared.setImage(urlString, img)
        activityIndicator.stopAnimating()
    }
    func imageFailure(_ errorMsg: String){
        activityIndicator.stopAnimating()
        print(errorMsg)
    }
}
