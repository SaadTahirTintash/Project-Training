//
//  File.swift
//  Footy-Crazy
//
//  Created by Tintash on 17/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//
import UIKit
import Foundation
import SwiftLinkPreview

struct FCCacheManager {
    //MARK:- static variables
    static let shared           : FCCacheManager             = FCCacheManager()
    
    //MARK:- private variables
    private var imageCache      : NSCache<NSString,UIImage>  = NSCache<NSString,UIImage>()
    private var newsLinkCache   : NSCache<NSString,Response> = NSCache<NSString,Response>()
    
    //MARK:- private initializer
    private init() {}
}

extension FCCacheManager {
    
    /// getter for cached image
    ///
    /// - Parameter url: key
    /// - Returns: cached image
    func getImage(_ url: String)->UIImage? {
        return imageCache.object(forKey: url as NSString)
    }
    
    /// setter for image
    ///
    /// - Parameters:
    ///   - url: key
    ///   - image: image to save
    func setImage(_ url: String,_ image: UIImage) {
        imageCache.setObject(image, forKey: url as NSString)
    }
    
    /// getter for cached NewsLink Response
    ///
    /// - Parameter url: key
    /// - Returns: cached response object
    func getNewsLink(_ url: String)->Response? {
        return newsLinkCache.object(forKey: url as NSString)
    }
    
    /// setter for news link
    ///
    /// - Parameters:
    ///   - url: key
    ///   - response: response object to save
    func setNewsLink(_ url: String,_ response: Response) {
        newsLinkCache.setObject(response, forKey: url as NSString)
    }
}
