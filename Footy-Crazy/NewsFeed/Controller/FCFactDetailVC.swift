//
//  FCNewsFeedDetailVC.swift
//  Footy-Crazy
//
//  Created by Tintash on 09/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCFactDetailVC: UIViewController {

    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    var viewModel: FCNewsFeedDetailVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    func setupVC(){
        //initial setup
        descriptionLabel.text = viewModel?.description
        titleLabel.text = viewModel?.title
        if let urlString = viewModel?.url{
            if let url = URL(string: urlString){
                imgView.loadImage(from: url){[weak self](_,_) in
                    self?.activityIndicator.stopAnimating()
                }
            }
        }        
    }

}
