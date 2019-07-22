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
        if let imageUrl = viewModel?.imageUrl{
            if let url = URL(string: imageUrl){
                playerDPImage.loadImage(from: url, success: nil) { (errorMsg) in
                    print(errorMsg)
                }
            }
        }
    }
    func loadImage(_ urlString: String){
        if let cache = FCCacheManager.shared.getImage(urlString){
            playerDPImage.image = cache
            print("Image loaded from cache")
        } else if let url = URL(string: urlString){
            playerDPImage.loadImage(from: url, success: { (img) in
                FCCacheManager.shared.setImage(urlString, img)
            }) { (errorMsg) in
                print(errorMsg)
            }
        }
    }

    override func prepareForReuse() {
        playerDPImage.image = nil
    }
}
