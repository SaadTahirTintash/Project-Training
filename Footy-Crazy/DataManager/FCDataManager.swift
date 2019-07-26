//
//  FCDataManager.swift
//  Footy-Crazy
//
//  Created by Tintash on 01/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

struct FCDataManager {
    
    static var shared               : FCDataManager             = FCDataManager()
    private var newsFeedData        : [FCNewsFeedModel]         = []
    private var galleryData         : [FCGalleryModel]          = []
    private var teamsData           : [FCTeamsModel]            = []
    private var playersData         : [FCPlayersModel]          = []
    private var citiesLocationData  : [FCCitiesLocationModel]   = []
}

extension FCDataManager {
    
    func getNewsFeedData()->[FCNewsFeedModel] {
        return newsFeedData
    }
    
    mutating func addNewsFeedData(item: [FCNewsFeedModel]){
        newsFeedData.append(contentsOf: item)
    }
    
    mutating func addGalleryData(item: [FCGalleryModel]){
        galleryData.append(contentsOf: item)
    }
    
    mutating func addTeamsData(item: [FCTeamsModel]){
        teamsData.append(contentsOf: item)
    }
    
    mutating func addPlayersData(item: [FCPlayersModel]){
        playersData.append(contentsOf: item)
    }
    
    mutating func addCitiesLocationData(item: [FCCitiesLocationModel]){
        citiesLocationData.append(contentsOf: item)
    }
}

