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
    
    var newsFeedModelArray: [FCNewsFeedModel] = [FCNewsFeedModel]()
    var galleryModelArray: [FCGalleryModel] = [FCGalleryModel]()
    
    private init(){
        networkEngine = NetworkEngine()
    }
    
    //this function requests data from server with appropriate key and page size, on response it appends data into its respective model and calls completion
    func getNewsFeed(startingKey id: String, pageSize limit: Int, completion: @escaping(_ success: Bool, _ newsFeedModelArray: [FCNewsFeedModel]?)->()){
        networkEngine?.loadNewsFeed(startingKey: id, pageSize: limit, completion: { [weak self] (success, newsFeedModelArray) in            
            if success, let array = newsFeedModelArray{
                self?.newsFeedModelArray = array
            }
            completion(success,newsFeedModelArray)
        })
    }
    
    func getGallery(startingKey id: String, pageSize limit: Int, completion: @escaping(_ success: Bool,_ galleryModelArray: [FCGalleryModel]?)->()){
        networkEngine?.loadGallery(startingKey: id, pageSize: limit, completion: { [weak self](success, galleryModelArray) in
            if success, let array = galleryModelArray{
                self?.galleryModelArray = array
            }
            completion(success,galleryModelArray)
        })
    }
    
    //MARK: Remove observers
    func removeAllObservers(){
        networkEngine?.removeAllObservers()
    }
    
}
