//
//  FCTeamCell.swift
//  Footy-Crazy
//
//  Created by Tintash on 11/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCTeamTableViewCell: UITableViewCell {

    @IBOutlet weak var standingLabel: UILabel!
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var country: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        flagImage.layer.masksToBounds = true
        flagImage.layer.cornerRadius = flagImage.frame.width/2        
    }

    func setupCell(_ model: FCTeamsModel){
        if let standing = model.standing{
            standingLabel.text = String(standing)
        }
        if let name = model.name{
            teamName.text = name
        }
        if let countryName = model.country{
            country.text = countryName
        }
        if let imgString = model.flagUrl{
            if let url = URL(string: imgString){
                flagImage.loadImage(from: url, completion: nil)
            }
        }
    }
}
