//
//  FCImageDownloader.swift
//  Footy-Crazy
//
//  Created by Tintash on 24/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import Foundation
import UIKit

protocol FCImageDownloader {}

extension FCImageDownloader{
    func loadImage(from url: String?, success: @escaping((_ img: UIImage,_ urlString: String)->Void), failure: @escaping((_ msg: String)->Void)){
        
        guard let urlString = url else{
            failure("Incorrect URL string!")
            return
        }
        
        if let cache = FCCacheManager.shared.getImage(urlString){
            success(cache,urlString)
        }else {
            DispatchQueue.global().async {
                guard let url = URL(string: urlString) else{
                    failure("URL conversion failure!")
                    return
                }
                guard let data = try? Data(contentsOf: url) else{
                    failure("URL Data conversion failure!")
                    return
                }
                guard let image = UIImage(data: data) else{
                    failure("Error while downloading image data!")
                    return
                }
                FCCacheManager.shared.setImage(urlString, image)
                success(image,urlString)
            }
        }
    }
}
