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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
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
            loadImage(imageUrl)
        }
    }
    func loadImage(_ urlString: String){
        if let cache = FCCacheManager.shared.getImage(urlString){
            flagImage.image = cache
            print("Image loaded from cache")
            activityIndicator.stopAnimating()
        } else if let url = URL(string: urlString){
            flagImage.loadImage(from: url){[weak self](success,downloadedImg) in
                if success{
                    print("Image downloaded from internet")
                    if let downloadedImg = downloadedImg{
                        FCCacheManager.shared.setImage(urlString, downloadedImg)
                    }
                }
                self?.activityIndicator.stopAnimating()
            }
        }
    }
}
