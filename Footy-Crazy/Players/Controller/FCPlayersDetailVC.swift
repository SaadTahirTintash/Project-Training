//
//  FCPlayersDetailVC.swift
//  Footy-Crazy
//
//  Created by Tintash on 11/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCPlayersDetailVC: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var nameLabel        : UILabel!
    @IBOutlet weak var clubLabel        : UILabel!
    @IBOutlet weak var countryLabel     : UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    @IBOutlet weak var standingLabel    : UILabel!
    @IBOutlet weak var playerImage      : UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK:- Public Properties
    var viewModel                       : FCPlayersDetailVM?
    
    //MARK:- Class Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
}

//MARK:- Image Downloading
extension FCPlayersDetailVC: FCImageDownloader {
    
    func setupVC() {
        
        if let name = viewModel?.playerName{
            nameLabel.text = name
        }
        if let club = viewModel?.clubName{
            clubLabel.text = "Club: \(club)"
        }
        if let country = viewModel?.countryName{
            countryLabel.text = "Country: \(country)"
        }
        if let description = viewModel?.playerDescription{
            descriptionLabel.text = description
        }
        if let standing = viewModel?.playerStanding{
            standingLabel.text = "Standing: \(standing)"
        }
        
        loadImage(from: viewModel?.imageUrl, success: { [weak self] (downloadedImg, urlString) in
            self?.success(self?.playerImage, self?.activityIndicator, downloadedImg)
        }) { [weak self] (errorMsg) in
            self?.failure(self?.playerImage, self?.activityIndicator, errorMsg)
        }
    }
}


