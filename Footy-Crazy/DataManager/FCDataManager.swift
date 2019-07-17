//
//  FCDataManager.swift
//  Footy-Crazy
//
//  Created by Tintash on 01/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//
class FCDataManager{
    static let shared = FCDataManager()
    var newsFeedModelArray: [FCNewsFeedModel] = [FCNewsFeedModel]()
    var galleryModelArray: [FCGalleryModel] = [FCGalleryModel]()
    var teamsModelArray: [FCTeamsModel] = [FCTeamsModel]()
    var playersModelArray: [FCPlayersModel] = [FCPlayersModel]()
    private init(){}
    func getNewsFeed(startingKey id: String, pageSize limit: Int, completion: @escaping(_ success: Bool, _ newsFeedModelArray: [FCNewsFeedModel]?)->()){
        FCNetworkEngine.shared.loadNewsFeed(startingKey: id, pageSize: limit, completion: { [weak self] (success, newsFeedModelArray) in
            if success, let array = newsFeedModelArray{
                self?.newsFeedModelArray = array
            }
            completion(success,newsFeedModelArray)
        })
    }
    func getGallery(startingKey id: String, pageSize limit: Int, completion: @escaping(_ success: Bool,_ galleryModelArray: [FCGalleryModel]?)->()){
        FCNetworkEngine.shared.loadGallery(startingKey: id, pageSize: limit, completion: { [weak self](success, galleryModelArray) in
            if success, let array = galleryModelArray{
                self?.galleryModelArray = array
            }
            completion(success,galleryModelArray)
        })
    }
    func getTeams(startingKey id: String, pageSize limit: Int, completion: ((_ success: Bool, _ teamsModelArray: [FCTeamsModel]?)->Void)?){
        FCNetworkEngine.shared.loadTeams(startingKey: id, pageSize: limit, completion: { [weak self] (success, teamsModelArray) in
            if success, let array = teamsModelArray{
                self?.teamsModelArray = array
            }
            completion?(success,teamsModelArray)
        })
    }
    func getPlayers(startingKey id: String, pageSize limit: Int, completion: ((_ success: Bool, _ playersModelArray: [FCPlayersModel]?)->Void)?){
        FCNetworkEngine.shared.loadPlayers(startingKey: id, pageSize: limit, completion: { [weak self] (success, playersModelArray) in
            if success, let array = playersModelArray{
                self?.playersModelArray = array
            }
            completion?(success,playersModelArray)
        })
    }
    func removeAllObservers(){
        FCNetworkEngine.shared.removeAllObservers()
    }
}
