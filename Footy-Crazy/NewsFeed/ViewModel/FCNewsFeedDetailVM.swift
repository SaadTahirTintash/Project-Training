//
//  FCFactDetailVM.swift
//  Footy-Crazy
//
//  Created by Tintash on 16/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCNewsFeedDetailVM {
    
    //MARK:- Private Properties
    private var model   : FCNewsFeedModel
    
    //MARK:- Initialization
    init(_ model: FCNewsFeedModel) {
        self.model = model
    }
    
    //MARK:- Computed Properties
    var title: String?{
        return model.title
    }
    
    var url: String?{
        return model.url
    }
    
    var description: String?{
        return model.description
    }
    
    var type: String?{
        return model.type?.rawValue
    }
}
