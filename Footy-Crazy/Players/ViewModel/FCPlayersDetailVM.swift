//
//  FCPlayersDetailVM.swift
//  Footy-Crazy
//
//  Created by Tintash on 16/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCPlayersDetailVM {
    
    //MARK:- Private Properties
    private var model   : FCPlayersModel
    
    //MARK:- Initialization
    init(_ model: FCPlayersModel) {
        self.model = model
    }
    
    //MARK:- Computed Properties
    var playerName: String?{
        return model.name
    }
    
    var countryName: String?{
        return model.country
    }
    
    var clubName: String?{
        return model.club
    }
    
    var playerStanding: String?{
        return model.standing
    }
    
    var playerDescription: String?{
        return model.description
    }
    
    var imageUrl: String?{
        return model.playerDPUrl
    }
}
