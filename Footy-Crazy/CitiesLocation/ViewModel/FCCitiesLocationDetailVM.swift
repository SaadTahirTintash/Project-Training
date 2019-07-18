//
//  FCCitiesLocationDetailVM.swift
//  Footy-Crazy
//
//  Created by Tintash on 18/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import Foundation

enum LocationType: String {
    case None
    case City
    case State
    case Province
}

class FCCitiesLocationDetailVM{
    var model: FCCitiesLocationModel
    init(_ model: FCCitiesLocationModel) {
        self.model = model
    }
    var lattitude: String{
        let latt_long = model.latt_long.components(separatedBy: ",")
        return latt_long[0]
    }
    var longitude: String{
        let latt_long = model.latt_long.components(separatedBy: ",")
        return latt_long[1]
    }
    var title: String{
        return model.title
    }
    var type: String{
        switch model.location_type {
        case "City":
            return LocationType.City.rawValue
        case "State":
            return LocationType.State.rawValue
        case "Province":
            return LocationType.Province.rawValue
        default:
            return LocationType.None.rawValue
        }
    }
    var woeid: Int{
        return model.woeid
    }
}
