//
//  FCCitiesLocationCell.swift
//  Footy-Crazy
//
//  Created by Tintash on 18/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCCitiesLocationCell: UITableViewCell {

    @IBOutlet weak var lattitdeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var woeidLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    var viewModel: FCCitiesLocationDetailVM?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(){
        if let lattitude = viewModel?.lattitude{
            lattitdeLabel.text = lattitude
        }
        if let longitude = viewModel?.longitude{
            longitudeLabel.text = longitude
        }
        if let title = viewModel?.title{
            titleLabel.text = title
        }
        if let woeid = viewModel?.woeid{
            woeidLabel.text = String(woeid)
        }
        if let type = viewModel?.type{
            typeLabel.text = type
        }
    }
    
}
