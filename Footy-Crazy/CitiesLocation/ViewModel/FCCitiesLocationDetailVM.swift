//
//  FCCitiesLocationDetailVM.swift
//  Footy-Crazy
//
//  Created by Tintash on 18/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import Foundation



class FCCitiesLocationDetailVM {
    
    //MARK:- Private Properties
    private var model: FCCitiesLocationModel
    
    //MARK:- Initialization
    init(_ model: FCCitiesLocationModel) {
        self.model = model
    }
    
    //MARK:- Computed Properties
    var lattitude: String {
        let latt_long = model.latt_long.components(separatedBy: ",")
        return latt_long[0]
    }
    
    var longitude: String {
        let latt_long = model.latt_long.components(separatedBy: ",")
        return latt_long[1]
    }
    
    var title: String {
        return model.title
    }
    
    var type: String {
        return model.location_type.rawValue
    }
    
    var woeid: Int {
        return model.woeid
    }
}
