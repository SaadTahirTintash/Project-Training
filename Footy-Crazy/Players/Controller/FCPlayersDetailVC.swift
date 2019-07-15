//
//  FCPlayersDetailVC.swift
//  Footy-Crazy
//
//  Created by Tintash on 11/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCPlayersDetailVC: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var clubLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var standingLabel: UILabel!
    @IBOutlet weak var playerImage: UIImageView!
    var model: FCPlayersModel = FCPlayersModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    func setupVC(){
        if let name = model.name{
            nameLabel.text = name
        }
        if let club = model.club{
            clubLabel.text = "Club: \(club)"
        }
        if let country = model.country{
            countryLabel.text = "Country: \(country)"
        }
        if let description = model.description{
            descriptionLabel.text = description
        }
        if let standing = model.standing{
            standingLabel.text = "Standing: \(standing)"
        }
        if let imgString = model.playerDPUrl{
            if let url = URL(string: imgString){
                playerImage.loadImage(from: url, completion: nil)
            }
        }
    }

}
