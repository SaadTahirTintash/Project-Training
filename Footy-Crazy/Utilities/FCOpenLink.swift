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
    
    func openLinkInSafari(_ urlString: String,_ nvc: UINavigationController?){
        print("open news link")
        guard let url = URL(string: urlString) else{
            print("Invalid URL")
            return
        }
        let svc = SFSafariViewController(url: url)
        nvc?.present(svc, animated: true, completion: nil)
    }
    
}
