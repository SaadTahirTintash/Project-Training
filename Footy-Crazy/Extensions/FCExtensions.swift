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
    typealias successType = ((_ img: UIImage)->Void)?
    typealias failureType = ((_ msg: String)->Void)?
    func loadImage(from url: URL, success: successType, failure: failureType){
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self?.image = image
                        success?(image)
                    }
                } else{
                    failure?("Image downloading failed!")
                }
            } else{
                failure?("Incorrect URL!")
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

extension UICollectionViewCell{
    convenience init(_ bgColor: UIColor = .clear){
        self.init()
        backgroundColor = bgColor
    }
}
