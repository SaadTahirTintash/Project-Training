//
//  FCShareContent.swift
//  Footy-Crazy
//
//  Created by Tintash on 24/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//
import UIKit

//MARK:- Definition
protocol FCShareContent {}

//MARK:- Extension
extension FCShareContent {
    
    /// Sharing images, String, Any data on a view
    ///
    /// - Parameters:
    ///   - onVC: Pops the sharing dialogue on view of this VC
    ///   - shareableContent: Images Strings Any
    func shareContent(_ onVC: UIViewController,
                      _ shareableContent: [Any]) {
        
        let activityViewController = UIActivityViewController(activityItems: shareableContent, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = onVC.view
        onVC.present(activityViewController, animated: true, completion: nil)
        
    }
    
}
