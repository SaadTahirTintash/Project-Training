//
//  FCTeamsDetailVC.swift
//  Footy-Crazy
//
//  Created by Tintash on 11/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCTeamsDetailVC: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var standingLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var flagImage: UIImageView!
    
    var model: FCTeamsModel = FCTeamsModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    func setupVC(){
        if let name = model.name{
            nameLabel.text = name
        }
        if let standing = model.standing{
            standingLabel.text = standing
        }        
        if let country = model.country{
            countryLabel.text = country
        }
        if let description = model.description{
            descriptionLabel.text = description
        }
        if let imgString = model.flagUrl{
            if let url = URL(string: imgString){
                flagImage.loadImage(from: url, completion: nil)
            }
        }
    }
}
