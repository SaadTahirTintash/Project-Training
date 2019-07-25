//
//  FCPlayersTableViewCell.swift
//  Footy-Crazy
//
//  Created by Tintash on 11/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit
class FCPlayerTableViewCell: UITableViewCell,FCImageDownloader {
    @IBOutlet weak var standingLabel        : UILabel!
    @IBOutlet weak var playerDPImage        : UIImageView!
    @IBOutlet weak var playerName           : UILabel!
    @IBOutlet weak var countryName          : UILabel!
    @IBOutlet weak var clubName             : UILabel!
    
    var viewModel                           : FCPlayersDetailVM?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(){
        if let standing = viewModel?.playerStanding{
            standingLabel.text = standing
        }
        if let name = viewModel?.playerName{
            playerName.text = name
        }
        if let country = viewModel?.countryName{
            countryName.text = country
        }
        if let club = viewModel?.clubName{
            clubName.text = club
        }
        loadImage(from: viewModel?.imageUrl, success: {[weak self](downloadedImg,urlString) in
            guard urlString == self?.viewModel?.imageUrl else{
                print("Wrong cell!")
                return
            }
            self?.success(self?.playerDPImage, nil, downloadedImg)
            }, failure: {[weak self](errorMsg) in
                self?.failure(self?.playerDPImage, nil, errorMsg)
        })
    }
    
    override func prepareForReuse() {
        playerDPImage.image = nil
    }
}
