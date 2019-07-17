//
//  FCTeamsDetailVC.swift
//  Footy-Crazy
//
//  Created by Tintash on 11/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit
class FCTeamsDetailVC: UIViewController {
    @IBOutlet weak var nameLabel        : UILabel!
    @IBOutlet weak var standingLabel    : UILabel!
    @IBOutlet weak var countryLabel     : UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    @IBOutlet weak var flagImage        : UIImageView!
    var viewModel                       : FCTeamsDetailVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }    
    func setupVC(){
        if let name = viewModel?.teamName{
            nameLabel.text = name
        }
        if let standing = viewModel?.teamStanding{
            standingLabel.text = "Ranking: \(standing)"
        }        
        if let country = viewModel?.countryName{
            countryLabel.text = "Country: \(country)"
        }
        if let description = viewModel?.teamDescription{
            descriptionLabel.text = description
        }
        if let imageUrl = viewModel?.imageUrl{
            if let url = URL(string: imageUrl){
                flagImage.loadImage(from: url, completion: nil)
            }
        }
    }
}
