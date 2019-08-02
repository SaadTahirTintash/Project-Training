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
    
    //MARK:- Outlets
    @IBOutlet weak var activityIndicator        : UIActivityIndicatorView!
    @IBOutlet weak var titleLabel               : UILabel!
    @IBOutlet weak var descriptionLabel         : UILabel!
    @IBOutlet weak var urlButton                : UIButton!
    @IBOutlet weak var imgView                  : UIImageView!
    
    //MARK:- Public Properties
    var viewModel                               : FCNewsFeedDetailVM?
    
    //MARK:- Class Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
}

//MARK:- Open Link Protocol
extension FCNewsLinkDetailVC: FCOpenLink {
    
    @IBAction func urlButtonAction(_ sender: Any) {
        if let urlString = viewModel?.url {
            openLinkInSafari(urlString, self.navigationController)
        }
    }
}

//MARK:- News Link Downloading
extension FCNewsLinkDetailVC: FCNewsLinkDownloader {
    
   func setupVC() {
        
        titleLabel.text         = viewModel?.title
        descriptionLabel.text   = viewModel?.description
        urlButton.setTitle(viewModel?.url, for: .normal)
        loadLink(from: viewModel?.url, success: linkSuccess){ [weak self] (errorMsg) in
            self?.failure(self?.imgView, self?.activityIndicator, errorMsg)
        }
    }
}

//MARK:- Image Downloading
extension FCNewsLinkDetailVC: FCImageDownloader {
    
    func linkSuccess(_ response: Response){
        
        titleLabel.text         = response.title
        descriptionLabel.text   = response.description
        if let imgUrlString     = response.image{
            loadImage(from: imgUrlString, success: { [weak self] (downloadedImg, urlString) in
                self?.success(self?.imgView, self?.activityIndicator, downloadedImg)
            }) { [weak self] (errorMsg) in
                self?.failure(self?.imgView, self?.activityIndicator, errorMsg)
            }
        }
    }
}
