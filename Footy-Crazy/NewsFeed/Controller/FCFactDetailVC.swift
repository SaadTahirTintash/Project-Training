//
//  FCNewsFeedDetailVC.swift
//  Footy-Crazy
//
//  Created by Tintash on 09/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCFactDetailVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    var model: FCNewsFeedModel = FCNewsFeedModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        // Do any additional setup after loading the view.
    }
    
    func setupVC(){
        //initial setup
        descriptionLabel.text = model.description
        titleLabel.text = model.title
        if let urlString = model.url{
            if let url = URL(string: urlString){
                imgView.loadImage(from: url, completion: nil)
            }
        }        
    }

}
