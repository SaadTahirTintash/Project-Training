//
//  FCPlayersTableViewCell.swift
//  Footy-Crazy
//
//  Created by Tintash on 11/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCPlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var standingLabel: UILabel!
    @IBOutlet weak var countryFlag: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var clubName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(_ model: FCPlayersModel){
        if let standing = model.standing{
            standingLabel.text = standing
        }
        if let name = model.name{
            playerName.text = name
        }
        if let country = model.country{
            countryName.text = country
        }
        if let club = model.club{
            clubName.text = club
        }
        if let imageUrl = model.playerDPUrl{
            if let url = URL(string: imageUrl){
                countryFlag.loadImage(from: url, completion: nil)
            }
        }
    }
    
}
