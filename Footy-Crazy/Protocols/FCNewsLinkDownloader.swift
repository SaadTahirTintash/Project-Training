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

protocol FCNewsLinkDownloader{}

extension FCNewsLinkDownloader{
    func loadLink(from urlString: String?, success: @escaping((_ response: Response)->Void), failure: @escaping((_ error: String)->Void)){
        
        guard let url = urlString else {
            print("Incorrect URL!")
            return
        }
        if let response = FCCacheManager.shared.getNewsLink(url){
            print("Response Loaded from cache!")
            success(response)
        }else{
            print("Response network request!")
            let slp : SwiftLinkPreview = SwiftLinkPreview()
            slp.preview(url, onSuccess: { (response) in
                FCCacheManager.shared.setNewsLink(url, response)
                success(response)
            }, onError: {(error) in
                failure(error.localizedDescription)
            })
        }
    }
}
