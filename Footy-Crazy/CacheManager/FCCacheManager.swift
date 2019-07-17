//
//  File.swift
//  Footy-Crazy
//
//  Created by Tintash on 17/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//
import UIKit
import Foundation

class FCCacheManager{
    static let shared   : FCCacheManager            = FCCacheManager()
    var imageCache           : NSCache<NSString,UIImage> = NSCache<NSString,UIImage>()
    private init() {}
    func getImage(_ url: String)->UIImage?{
        return imageCache.object(forKey: url as NSString)
    }
    func setImage(_ url: String,_ image: UIImage){        
        imageCache.setObject(image, forKey: url as NSString)
    }
}
