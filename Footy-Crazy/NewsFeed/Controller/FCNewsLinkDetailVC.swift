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

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var urlButton: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    var viewModel: FCNewsFeedDetailVM?
    let slp = SwiftLinkPreview()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        // Do any additional setup after loading the view.
    }
    
    func setupVC(){
        //initial setup
        descriptionLabel.text = viewModel?.description
        titleLabel.text = viewModel?.title
        urlButton.setTitle(viewModel?.url, for: .normal)
        if let urlString = viewModel?.url{
            loadLink(urlString)
        }
    }
    
    @IBAction func urlButtonAction(_ sender: Any) {
        if let urlString = viewModel?.url {
            FCUtilities.openLinkInSafari(urlString, self.navigationController)
        }
    }
    
    func loadLink(_ newsLink: String){
        slp.preview(newsLink, onSuccess: { [weak self] (response) in
            self?.titleLabel.text   = response.title
            self?.urlButton.setTitle(response.url?.absoluteString, for: .normal)
            self?.descriptionLabel.text = response.description
            if let urlString = response.image{
                if let url = URL(string: urlString){
                    self?.imgView.loadImage(from: url){[weak self](_,_) in
                        self?.activityIndicator.stopAnimating()
                    }
                }
            }
        }) { [weak self](error) in
            self?.imgView.image = Constants.EMPTY_IMAGE
        }
    }

}
