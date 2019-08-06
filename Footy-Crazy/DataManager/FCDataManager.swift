//
//  FCDataManager.swift
//  Footy-Crazy
//
//  Created by Tintash on 01/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

// Code Review: make these variable private and write setter /getter methods for them.
class FCDataManager {
    // Code Review: added line spaces between static variable, class properties and intializer
    static let shared       : FCDataManager             = FCDataManager()
    var newsFeedData        : [FCNewsFeedModel]         = []
    var galleryData         : [FCGalleryModel]          = []
    var teamsData           : [FCTeamsModel]            = []
    var playersData         : [FCPlayersModel]          = []
    var citiesLocationData  : [FCCitiesLocationModel]   = []
    private init(){}
}

