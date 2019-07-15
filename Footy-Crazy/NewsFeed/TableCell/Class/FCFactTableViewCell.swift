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
//    @IBOutlet weak var factLabel: UILabel!
    var downloadedImg: UIImage?
    weak var shareBtnDelegate: FCNewsFeedShareButtonDelegate?
    var newsFeedModel: FCNewsFeedModel = FCNewsFeedModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(_ model: FCNewsFeedModel){
        titleLabel.text = model.title
//        factLabel.text = model.description
        if let urlString = model.url{
            if let url = URL(string: urlString){
                    imgView.loadImage(from: url, completion: nil)
            }
        }
        
        saveModel(model)
    }
    
    func saveModel(_ model: FCNewsFeedModel){
        newsFeedModel.title = model.title
//        newsFeedModel.description = model.description
        newsFeedModel.url = model.url
    }
    
    @IBAction func share(_ sender: Any) {
        shareBtnDelegate?.didPressShareButton(newsFeedModel)
    }
    
    override func prepareForReuse() {
        self.imgView.image = nil
    }
    
}
