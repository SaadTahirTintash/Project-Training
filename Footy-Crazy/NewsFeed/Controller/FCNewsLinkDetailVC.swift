//
//  FCNewsLinkDetailVC.swift
//  Footy-Crazy
//
//  Created by Tintash on 10/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit
import SwiftLinkPreview

class FCNewsLinkDetailVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    var model = FCNewsFeedModel()
    let slp = SwiftLinkPreview()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        // Do any additional setup after loading the view.
    }
    
    func setupVC(){
        //initial setup
        descriptionLabel.text = model.description
        titleLabel.text = model.title
        urlLabel.text = model.url
        loadLink(model.url)
    }
    
    func loadLink(_ newsLink: String){
        slp.preview(newsLink, onSuccess: { [weak self] (response) in
            self?.titleLabel.text   = response.title
            self?.urlLabel.text     = response.url?.absoluteString
            self?.descriptionLabel.text = response.description
            if let imgURL = response.image{
                self?.imgView.loadImage(from: URL(string: imgURL)!, completion: nil)
            } else{
                self?.imgView.image = Constants.EMPTY_IMAGE
            }
        }) { [weak self](error) in
            self?.imgView.image = Constants.EMPTY_IMAGE
        }
    }

}
