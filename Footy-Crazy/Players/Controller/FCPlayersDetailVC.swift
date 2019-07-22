//
//  FCPlayersDetailVC.swift
//  Footy-Crazy
//
//  Created by Tintash on 11/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit
class FCPlayersDetailVC: UIViewController {
    @IBOutlet weak var nameLabel        : UILabel!
    @IBOutlet weak var clubLabel        : UILabel!
    @IBOutlet weak var countryLabel     : UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    @IBOutlet weak var standingLabel    : UILabel!
    @IBOutlet weak var playerImage      : UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var viewModel                       : FCPlayersDetailVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
}
extension FCPlayersDetailVC{
    func setupVC(){
        if let name = viewModel?.playerName{
            nameLabel.text = name
        }
        if let club = viewModel?.clubName{
            clubLabel.text = "Club: \(club)"
        }
        if let country = viewModel?.countryName{
            countryLabel.text = "Country: \(country)"
        }
        if let description = viewModel?.playerDescription{
            descriptionLabel.text = description
        }
        if let standing = viewModel?.playerStanding{
            standingLabel.text = "Standing: \(standing)"
        }
        if let imageUrl = viewModel?.imageUrl{
            loadImage(imageUrl)
        }
    }
    func loadImage(_ urlString: String){
        if let cache = FCCacheManager.shared.getImage(urlString){
            playerImage.image = cache
            print("Image loaded from cache")
        } else if let url = URL(string: urlString){
            playerImage.loadImage(from: url, success: { [weak self](img) in
                FCCacheManager.shared.setImage(urlString, img)
                self?.activityIndicator.stopAnimating()
            }) { [weak self](errorMsg) in
                self?.activityIndicator.stopAnimating()
                print(errorMsg)
            }
        }
    }
}
