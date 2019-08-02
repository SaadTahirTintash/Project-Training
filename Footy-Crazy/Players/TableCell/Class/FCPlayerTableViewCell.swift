//
//  FCPlayersTableViewCell.swift
//  Footy-Crazy
//
//  Created by Tintash on 11/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCPlayerTableViewCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var standingLabel        : UILabel!
    @IBOutlet weak var playerDPImage        : UIImageView!
    @IBOutlet weak var playerName           : UILabel!
    @IBOutlet weak var countryName          : UILabel!
    @IBOutlet weak var clubName             : UILabel!
    
    //MARK:- Public Methods
    var viewModel                           : FCPlayersDetailVM?
    
    //MARK:- Class Methods
    override func prepareForReuse() {
        playerDPImage.image = nil
    }
}

//MARK:- Image Downloading
extension FCPlayerTableViewCell: FCImageDownloader {
    
    func configure() {
        
        if let standing = viewModel?.playerStanding {
            standingLabel.text = standing
        }
        if let name = viewModel?.playerName {
            playerName.text = name
        }
        if let country = viewModel?.countryName {
            countryName.text = country
        }
        if let club = viewModel?.clubName {
            clubName.text = club
        }
        
        loadImage(from: viewModel?.imageUrl, success: {[weak self](downloadedImg,urlString) in
            guard urlString == self?.viewModel?.imageUrl else{
                print(FCConstants.ERRORS.wrongCell)
                return
            }
            self?.success(self?.playerDPImage, nil, downloadedImg)
            }, failure: {[weak self](errorMsg) in
                self?.failure(self?.playerDPImage, nil, errorMsg)
        })
    }
}
