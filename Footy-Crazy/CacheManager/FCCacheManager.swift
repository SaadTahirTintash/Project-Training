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
    
    static let shared           : FCCacheManager             = FCCacheManager()
    private var imageCache      : NSCache<NSString,UIImage>  = NSCache<NSString,UIImage>()
    private var newsLinkCache   : NSCache<NSString,Response> = NSCache<NSString,Response>()
    
    private init() {}
}

extension FCCacheManager {
    
    func getImage(_ url: String)->UIImage? {
        return imageCache.object(forKey: url as NSString)
    }
    
    func setImage(_ url: String,_ image: UIImage) {
        imageCache.setObject(image, forKey: url as NSString)
    }
    
    func getNewsLink(_ url: String)->Response? {
        return newsLinkCache.object(forKey: url as NSString)
    }
    
    func setNewsLink(_ url: String,_ response: Response) {
        newsLinkCache.setObject(response, forKey: url as NSString)
    }
}
