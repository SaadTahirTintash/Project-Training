//
//  FCCitiesLocationModel.swift
//  Footy-Crazy
//
//  Created by Tintash on 18/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import Foundation

struct FCCitiesLocationModel: Decodable {
    
    var woeid           : Int
    var latt_long       : String
    var location_type   : LocationType
    var title           : String
}

enum LocationType: String, Decodable {
    case None
    case City
    case State
    case Province
}
