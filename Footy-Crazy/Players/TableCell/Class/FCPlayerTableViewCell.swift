//
//  FCPlayersTableViewCell.swift
//  Footy-Crazy
//
//  Created by Tintash on 11/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit
class FCPlayerTableViewCell: UITableViewCell {
    @IBOutlet weak var standingLabel        : UILabel!
    @IBOutlet weak var playerDPImage        : UIImageView!
    @IBOutlet weak var playerName           : UILabel!
    @IBOutlet weak var countryName          : UILabel!
    @IBOutlet weak var clubName             : UILabel!
    var viewModel                           : FCPlayersDetailVM?
    var imgCache                            : NSCache<NSString,UIImage> = NSCache<NSString,UIImage>()

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
    }
    func setImage(_ newImage: UIImage){
        playerDPImage.image = newImage
    }
    override func prepareForReuse() {
        playerDPImage.image = nil
    }
}
