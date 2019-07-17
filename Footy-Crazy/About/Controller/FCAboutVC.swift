//
//  FCAboutVC.swift
//  Footy-Crazy
//
//  Created by Tintash on 11/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit
class FCAboutVC: UIViewController {
    @IBOutlet weak var aboutLabel       : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    func setupVC(){
        aboutLabel.text = Constants.ABOUT_US
    }
}
