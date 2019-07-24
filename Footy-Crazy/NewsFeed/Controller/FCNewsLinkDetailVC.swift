//
//  FCNewsLinkDetailVC.swift
//  Footy-Crazy
//
//  Created by Tintash on 10/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit
import SwiftLinkPreview

class FCNewsLinkDetailVC: UIViewController, FCImageDownloader, FCNewsLinkDownloader, FCUtilities {
    
    @IBOutlet weak var activityIndicator        : UIActivityIndicatorView!
    @IBOutlet weak var titleLabel               : UILabel!
    @IBOutlet weak var descriptionLabel         : UILabel!
    @IBOutlet weak var urlButton                : UIButton!
    @IBOutlet weak var imgView                  : UIImageView!
    
    var viewModel                               : FCNewsFeedDetailVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
}

extension FCNewsLinkDetailVC{
    
    @IBAction func urlButtonAction(_ sender: Any) {
        if let urlString = viewModel?.url {
            openLinkInSafari(urlString, self.navigationController)
        }
    }
    
    func setupVC(){
        
        titleLabel.text         = viewModel?.title
        descriptionLabel.text   = viewModel?.description
        urlButton.setTitle(viewModel?.url, for: .normal)
        loadLink(from: viewModel?.url, success: linkSuccess, failure: failure)
    }
    
    func linkSuccess(_ response: Response){
        titleLabel.text         = response.title
        descriptionLabel.text   = response.description
        if let imgUrlString     = response.image{
            loadImage(from: imgUrlString, success: imgSuccess) { [weak self](errorMsg) in
                DispatchQueue.main.async {
                    self?.failure(errorMsg)
                }
            }
        }
    }
    
    func imgSuccess(_ downloadedImg: UIImage,_ urlString: String){
        activityIndicator.stopAnimating()
        imgView.image = downloadedImg
    }
    
    func failure(_ errorMsg: String){
        activityIndicator.stopAnimating()
        imgView.image = FCConstants.EMPTY_IMAGE
        print(errorMsg)
    }
    
}
