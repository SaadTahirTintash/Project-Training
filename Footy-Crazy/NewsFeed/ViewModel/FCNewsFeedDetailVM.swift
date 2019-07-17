//
//  FCFactDetailVM.swift
//  Footy-Crazy
//
//  Created by Tintash on 16/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit
class FCNewsFeedDetailVM{
    private var model   : FCNewsFeedModel
    init(_ model: FCNewsFeedModel) {
        self.model = model
    }    
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
        return model.type
    }
}
