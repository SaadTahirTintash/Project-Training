//
//  FCDataManager.swift
//  Footy-Crazy
//
//  Created by Tintash on 01/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

struct FCDataManager {
    
    //MARK:- static variables
    static var shared               : FCDataManager             = FCDataManager()
    
    //MARK:- private variables
    private var newsFeedData        : [FCNewsFeedModel]         = []
    private var galleryData         : [FCGalleryModel]          = []
    private var teamsData           : [FCTeamsModel]            = []
    private var playersData         : [FCPlayersModel]          = []
    private var citiesLocationData  : [FCCitiesLocationModel]   = []
    
    //MARK:- private initializer
    private init() {}
}

//MARK:- Extension
extension FCDataManager {
    
    //MARK:- Getter
    /// Model data for news feed
    ///
    /// - Returns: News Feed model array
    func getNewsFeedData()->[FCNewsFeedModel] {
        return newsFeedData
    }
    
    //MARK:- Methods
    /// Adding sequence to news feed array
    ///
    /// - Parameter item: an array of news feed model
    mutating func addNewsFeedData(item: [FCNewsFeedModel]){
        newsFeedData.append(contentsOf: item)
    }
    
    /// Adding sequence to gallery array
    ///
    /// - Parameter item: an array of gallery model
    mutating func addGalleryData(item: [FCGalleryModel]){
        galleryData.append(contentsOf: item)
    }
    
    /// Adding sequence to teams array
    ///
    /// - Parameter item: an array of teams model
    mutating func addTeamsData(item: [FCTeamsModel]){
        teamsData.append(contentsOf: item)
    }
    
    /// Adding sequence to players array
    ///
    /// - Parameter item: an array of players model
    mutating func addPlayersData(item: [FCPlayersModel]){
        playersData.append(contentsOf: item)
    }
    
    /// Adding sequence to cities location array
    ///
    /// - Parameter item: an array of cities location model
    mutating func addCitiesLocationData(item: [FCCitiesLocationModel]){
        citiesLocationData.append(contentsOf: item)
    }
}

