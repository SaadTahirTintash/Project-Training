//
//  FCTeamCell.swift
//  Footy-Crazy
//
//  Created by Tintash on 11/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit
class FCTeamTableViewCell: UITableViewCell {
    @IBOutlet weak var standingLabel    : UILabel!
    @IBOutlet weak var flagImage        : UIImageView!
    @IBOutlet weak var teamName         : UILabel!
    @IBOutlet weak var country          : UILabel!
    var viewModel                       : FCTeamsDetailVM?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configure(){
        standingLabel.text = viewModel?.teamStanding
        teamName.text = viewModel?.teamName
        country.text = viewModel?.countryName
        if let imageUrl = viewModel?.imageUrl{
            if let url = URL(string: imageUrl){
                flagImage.loadImage(from: url, completion: nil)
            }
        }
    }
}
