//
//  FCTeamCell.swift
//  Footy-Crazy
//
//  Created by Tintash on 11/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit
class FCTeamTableViewCell: UITableViewCell, FCImageDownloader {
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
        loadImage(from: viewModel?.imageUrl, success: {[weak self](downloadedImg,urlString) in
            guard urlString == self?.viewModel?.imageUrl else{
                print("Wrong cell!")
                return
            }
            DispatchQueue.main.async {
                self?.success(downloadedImg, urlString)
            }
        }, failure: {[weak self](errorMsg) in
            DispatchQueue.main.async {
                self?.failure(errorMsg)
            }
        })
    }
    func success(_ downloadedImg: UIImage,_ urlString: String){
        flagImage.image = downloadedImg
    }
    
    func failure(_ errorMsg: String){
        flagImage.image = FCConstants.EMPTY_IMAGE
        print(errorMsg)
    }
    override func prepareForReuse() {
        flagImage.image = FCConstants.EMPTY_IMAGE
    }
}
