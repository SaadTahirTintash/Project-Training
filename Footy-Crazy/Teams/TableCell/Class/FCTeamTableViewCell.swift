//
//  FCTeamCell.swift
//  Footy-Crazy
//
//  Created by Tintash on 11/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCTeamTableViewCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var standingLabel    : UILabel!
    @IBOutlet weak var flagImage        : UIImageView!
    @IBOutlet weak var teamName         : UILabel!
    @IBOutlet weak var country          : UILabel!
    
    //MARK:- Public Properties
    var viewModel                       : FCTeamsDetailVM?

    //MARK:- Class Methods
    override func prepareForReuse() {
        flagImage.image = FCConstants.EMPTY_IMAGE
    }
}

//MARK:- Image Downloading
extension FCTeamTableViewCell: FCImageDownloader {
    
    func configure() {
        standingLabel.text = viewModel?.teamStanding
        teamName.text = viewModel?.teamName
        country.text = viewModel?.countryName
        loadImage(from: viewModel?.imageUrl, success: {[weak self](downloadedImg,urlString) in
            guard urlString == self?.viewModel?.imageUrl else{
                print(FCConstants.ERRORS.wrongCell)
                return
            }
            self?.success(self?.flagImage, nil, downloadedImg)
        }, failure: {[weak self](errorMsg) in
            self?.failure(self?.flagImage, nil, errorMsg)
        })
    }
}
