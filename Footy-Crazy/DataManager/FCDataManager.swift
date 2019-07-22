//
//  FCDataManager.swift
//  Footy-Crazy
//
//  Created by Tintash on 01/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

class FCDataManager {
    
    static let shared = FCDataManager()
    var newsFeedData      : [FCNewsFeedModel]         = []
    var galleryData       : [FCGalleryModel]          = []
    var teamsData         : [FCTeamsModel]            = []
    var playersData       : [FCPlayersModel]          = []
    var citiesLocationData: [FCCitiesLocationModel]   = []
    private init(){}
}

