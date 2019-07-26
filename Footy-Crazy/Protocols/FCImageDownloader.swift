//
//  FCImageDownloader.swift
//  Footy-Crazy
//
//  Created by Tintash on 24/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import Foundation
import UIKit

protocol FCImageDownloader {
    
    typealias successType = (_ img: UIImage,_ urlString: String)->Void
    typealias failureType = (_ msg: String)->Void
}

extension FCImageDownloader {
    
    func loadImage(from     url : String?,
                   success      : @escaping successType,
                   failure      : @escaping failureType) {
        
        guard let urlString = url else{
            failure(FCConstants.ERRORS.invalidUrlString)
            return
        }
        
        if let cache = FCCacheManager.shared.getImage(urlString) {
            success(cache,urlString)
        } else {
            DispatchQueue.global().async {
                
                guard let url = URL(string: urlString) else{
                    failure(FCConstants.ERRORS.invalidUrl)
                    return
                }
                guard let data = try? Data(contentsOf: url) else{
                    failure(FCConstants.ERRORS.invalidUrlData)
                    return
                }
                guard let image = UIImage(data: data) else{
                    failure(FCConstants.ERRORS.imageDownloadingFailed)
                    return
                }
                
                FCCacheManager.shared.setImage(urlString, image)
                success(image,urlString)
            }
        }
    }
    
    func success(_ uiImageView: UIImageView?,
                 _ activityIndicator: UIActivityIndicatorView?,
                 _ downloadedImg: UIImage) {
        
        DispatchQueue.main.async {
            activityIndicator?.stopAnimating()
            uiImageView?.image = downloadedImg
        }
    }
    
    func failure(_ uiImageView: UIImageView?,
                 _ activityIndicator: UIActivityIndicatorView?,
                 _ errorMsg: String) {
        
        DispatchQueue.main.async {
            activityIndicator?.stopAnimating()
            uiImageView?.image = FCConstants.EMPTY_IMAGE
        }
        print(errorMsg)
    }
}
