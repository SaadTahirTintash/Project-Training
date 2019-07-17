//
//  FCTeamsDetailVM.swift
//  Footy-Crazy
//
//  Created by Tintash on 16/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit
class FCTeamsDetailVM{
    private var model   : FCTeamsModel
    init(_ model: FCTeamsModel) {
        self.model = model
    }
    var countryName: String?{
        return model.country?.capitalized
    }
    var teamName: String?{
        return model.name?.capitalized
    }
    var teamStanding: String?{
        return model.standing?.capitalized
    }
    var imageUrl: String?{
        return model.flagUrl
    }
    var teamDescription: String?{
        return model.description
    }    
}
