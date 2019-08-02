//
//  FCAboutVC.swift
//  Footy-Crazy
//
//  Created by Tintash on 11/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCAboutVC: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var aboutLabel       : UILabel!
    
    //MARK:- Class Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
}

//MARK:- Methods
extension FCAboutVC {

    func setupVC(){
        let attributedText = createAttributedString()
        aboutLabel.attributedText = attributedText
    }
    
    func createAttributedString()->NSAttributedString{
        let text = FCConstants.ABOUT_US
        
        let textColor = UIColor.red
        
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.gray
        shadow.shadowBlurRadius = 5
        
        let attributes : [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor  : textColor,
            NSAttributedString.Key.shadow           : shadow
        ]
        return NSAttributedString(string: text, attributes: attributes)
    }
}
