//
//  FCDataManager.swift
//  Footy-Crazy
//
//  Created by Tintash on 01/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

/*
 - It gets data from server, saves that data in itself and return that data to others 
 */



class FCDataManager{
    
    static let shared = FCDataManager()
    private let networkEngine : NetworkEngine?
    
    var newsFeedModel: FCNewsFeedModel = FCNewsFeedModel()
    
    private init(){
        networkEngine = NetworkEngine()
    }
    
    //this function requests data from server with appropriate key and page size, on response it appends data into its respective model and calls completion
    func getNewsFeed(key id: String, pageSize limit: Int, completion: @escaping(_ success: Bool, _ newsFeedModel: FCNewsFeedModel?)->()){
        networkEngine?.loadNewsFeed(key: id, pageSize: limit, completion: { [weak self] (success, newsFeedModel) in
            if success, let objects = newsFeedModel?.objects{
                self?.newsFeedModel.objects?.append(contentsOf: objects)
            }
            completion(success,newsFeedModel)
        })
    }
    
    //MARK: Remove observers
    func removeAllObservers(){
        networkEngine?.removeAllObservers()
    }
    
}
