//
//  FCOpenLink.swift
//  Footy-Crazy
//
//  Created by Tintash on 24/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import SafariServices

protocol FCOpenLink {}

extension FCOpenLink {
    
    /// Opens a link in safari without leaving the app
    ///
    /// - Parameters:
    ///   - urlString: url link to open
    ///   - nvc: navigation controller for coming back to last screen
    func openLinkInSafari(_ urlString: String,
                          _ nvc: UINavigationController?) {
        
        guard let url = URL(string: urlString) else {
            print(FCConstants.ERRORS.invalidUrl)
            return
        }
        
        let svc = SFSafariViewController(url: url)
        nvc?.present(svc, animated: true, completion: nil)
    }
    
}
