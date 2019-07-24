//
//  FCUtilities.swift
//  Footy-Crazy
//
//  Created by Tintash on 10/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import SafariServices

protocol FCUtilities {}
extension FCUtilities{
    func openLinkInSafari(_ urlString: String,_ nvc: UINavigationController?){
        print("open news link")
        guard let url = URL(string: urlString) else{
            print("Invalid URL")
            return
        }
        let svc = SFSafariViewController(url: url)
        nvc?.present(svc, animated: true, completion: nil)
    }
    func shareContent(_ onVC: UIViewController, _ shareableContent: [Any]){
        let activityViewController = UIActivityViewController(activityItems: shareableContent, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = onVC.view
        onVC.present(activityViewController, animated: true, completion: nil)
    }
}
