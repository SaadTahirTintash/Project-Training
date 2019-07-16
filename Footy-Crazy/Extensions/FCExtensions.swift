//
//  Extensions.swift
//  Footy-Crazy
//
//  Created by Tintash on 08/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//
import Foundation
import UIKit

extension UIImageView{
    
    func loadImage(from url: URL, completion: ((_ success:Bool,_ downloadedImg: UIImage?)->Void)?){
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url){
                print("Image loaded successfully")
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self?.image = image
                        completion?(true,image)
                    }
                }
            }
            else{
                print("Image Loading error")
                completion?(false,nil)
            }
        }
    }
}

extension UITableViewCell {
    convenience init(_ bgColor: UIColor = .clear) {
        self.init()
        backgroundColor = bgColor
    }
}
