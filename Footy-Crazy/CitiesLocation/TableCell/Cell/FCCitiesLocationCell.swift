//
//  FCCitiesLocationCell.swift
//  Footy-Crazy
//
//  Created by Tintash on 18/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCCitiesLocationCell: UITableViewCell {

    //MARK:- Outlets
    @IBOutlet weak var lattitdeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var woeidLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    //MARK:- Public Properties
    var viewModel: FCCitiesLocationDetailVM?
    
}

extension FCCitiesLocationCell {
    
    func configure() {
        
        guard let viewModel = viewModel else {
            return
        }
        
        lattitdeLabel.text  = viewModel.lattitude
        longitudeLabel.text = viewModel.longitude
        titleLabel.text     = viewModel.title
        woeidLabel.text     = String(viewModel.woeid)
        typeLabel.text      = viewModel.type
        
    }
    
}
