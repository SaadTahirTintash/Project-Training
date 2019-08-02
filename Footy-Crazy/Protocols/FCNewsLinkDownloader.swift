//
//  FCNewsLinkDownloader.swift
//  Footy-Crazy
//
//  Created by Tintash on 24/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import Foundation
import UIKit
import SwiftLinkPreview

//MARK:- Definition
protocol FCNewsLinkDownloader {
    
    typealias successType = (_ response: Response)->Void
    typealias failureType = (_ error: String)->Void
}

//MARK:- Extension
extension FCNewsLinkDownloader {
    
    //MARK:- Methods
    /// load link from the given url. Checks if url present in cache else downloads from server, saves the response in cache and calls success
    ///
    /// - Parameters:
    ///   - urlString: news link url
    ///   - success: success completion handler
    ///   - failure: failure completion handler
    func loadLink(from urlString: String?,
                  success: @escaping successType,
                  failure: @escaping failureType) {
        
        guard let url = urlString else {
            print(FCConstants.ERRORS.invalidUrl)
            return
        }
        
        if let response = FCCacheManager.shared.getNewsLink(url) {
            success(response)
        } else {
            let slp : SwiftLinkPreview = SwiftLinkPreview()
            slp.preview(url, onSuccess: { (response) in
                FCCacheManager.shared.setNewsLink(url, response)
                success(response)
            }, onError: { (error) in
                failure(error.localizedDescription)
            })
        }
    }
}
