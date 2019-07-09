//
//  FCFactTableViewCell.swift
//  Footy-Crazy
//
//  Created by Tintash on 01/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCFactTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var factLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(_ model: FCNewsFeedModel){
        titleLabel.text = model.title
        factLabel.text = model.description
        imgView.loadImage(from: URL(string: model.url)!, completion: nil)
    }
    
    override func prepareForReuse() {
        self.imgView.image = nil
    }
    
}
