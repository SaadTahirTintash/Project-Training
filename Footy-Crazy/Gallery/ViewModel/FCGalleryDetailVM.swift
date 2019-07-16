//
//  FCGalleryDetailVM.swift
//  Footy-Crazy
//
//  Created by Tintash on 15/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCGalleryDetailVM{
    
    private let model : FCGalleryModel
    
    init(model: FCGalleryModel) {
        self.model = model
    }
    
    var imageUrl: String?{
        return model.imageUrl
    }
    
    
}
