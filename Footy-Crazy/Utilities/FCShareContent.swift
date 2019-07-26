//
//  FCShareContent.swift
//  Footy-Crazy
//
//  Created by Tintash on 24/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//
import UIKit

protocol FCShareContent {}

extension FCShareContent {
    
    func shareContent(_ onVC: UIViewController,
                      _ shareableContent: [Any]) {
        
        let activityViewController = UIActivityViewController(activityItems: shareableContent, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = onVC.view
        onVC.present(activityViewController, animated: true, completion: nil)
        
    }
    
}
