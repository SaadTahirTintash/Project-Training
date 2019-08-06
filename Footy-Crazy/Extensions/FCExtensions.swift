//
//  Extensions.swift
//  Footy-Crazy
//
//  Created by Tintash on 08/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//
import Foundation
import UIKit

//Code review: Please add Mark to categories diffrent type extensions
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
