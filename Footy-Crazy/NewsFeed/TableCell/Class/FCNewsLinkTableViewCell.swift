//
//  FCNewsLinkTableViewCell.swift
//  Footy-Crazy
//
//  Created by Tintash on 01/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit
import SwiftLinkPreview

class FCNewsLinkTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var newsImg: UIImageView!
    @IBOutlet weak var urlLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    var newsFeedModel : FCNewsFeedModel = FCNewsFeedModel()
    weak var shareBtnDelegate: FCNewsFeedShareButtonDelegate?
    let slp = SwiftLinkPreview()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        newsImg.image = nil
    }
    
    func setupCell(_ model:  FCNewsFeedModel) {
        titleLbl.text   = model.title
        urlLbl.text     = model.url
        descriptionLbl.text = model.description
        newsImg.image       = model.image ?? Constants.EMPTY_IMAGE
        if let urlString = model.url{
            loadLink(urlString)
        }
        saveModel(model)
    }
    
    @IBAction func share(_ sender: Any) {
        shareBtnDelegate?.didPressShareButton(newsFeedModel)
    }
    
    func saveModel(_ model: FCNewsFeedModel){
        newsFeedModel.title = model.title
        newsFeedModel.description = model.description
        newsFeedModel.url = model.url
    }
    
    func loadLink(_ newsLink: String){
        slp.preview(newsLink, onSuccess: { [weak self] (response) in
            self?.titleLbl.text   = response.title
            self?.urlLbl.text     = response.url?.absoluteString
            self?.descriptionLbl.text = response.description
            if let imgURL = response.image{
                self?.newsImg.loadImage(from: URL(string: imgURL)!, completion: nil)
            } else{
                self?.newsImg.image = Constants.EMPTY_IMAGE
            }
        }) { [weak self](error) in
            self?.newsImg.image = Constants.EMPTY_IMAGE
        }
    }
    
}
