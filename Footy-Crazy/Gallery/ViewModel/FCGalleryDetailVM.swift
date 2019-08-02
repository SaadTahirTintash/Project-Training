//
//  FCGalleryDetailVM.swift
//  Footy-Crazy
//
//  Created by Tintash on 15/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCGalleryDetailVM {
    
    //MARK:- Private Properties
    private let model   : FCGalleryModel
    
    //MARK:- Computed Properties
    var imageUrl: String?{
        return model.url
    }
    
    //MARK:- Initialization
    init(model: FCGalleryModel) {
        self.model = model
    }
}
