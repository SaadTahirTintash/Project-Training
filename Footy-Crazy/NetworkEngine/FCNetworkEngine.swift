//
//  FCNetworkEngine.swift
//  Footy-Crazy
//
//  Created by Tintash on 28/06/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//


import FirebaseDatabase


class FCNetworkEngine{
    static let shared = FCNetworkEngine()
    let snapshotParser = FCParseSnapshot()
    var ref: DatabaseReference!
    var rootQuery = DatabaseReference()
    private init() {
        ref = Database.database().reference()
        rootQuery = ref.child("footy_crazy_data")
    }
    func loadNewsFeed(startingKey id: String, pageSize limit: Int, completion: ((_ success: Bool, _ newsFeedModelArray: [FCNewsFeedModel]?)->Void)?){
        rootQuery.child(Constants.NEWS_FEED_PATH_STRING).queryOrderedByKey().queryStarting(atValue: id).queryLimited(toFirst: UInt(limit)).observeSingleEvent(of: .value) { [weak self] (snapshot) in
            if snapshot.value != nil && snapshot.childrenCount > 0{
                let newsFeedModelArray = self?.snapshotParser.parseToNewsFeed(snapshot: snapshot)
                completion?(true,newsFeedModelArray)
            } else{
                completion?(false,nil)
            }
        }
    }
    func loadGallery(startingKey id: String, pageSize limit: Int, completion:((_ success: Bool,_ galleryModelArray: [FCGalleryModel]?)->Void)?){
        rootQuery.child(Constants.GALLERY_PATH_STRING).queryOrderedByKey().queryStarting(atValue: id).queryLimited(toFirst: UInt(limit)).observeSingleEvent(of: .value) { [weak self](snapshot) in
            if snapshot.value != nil && snapshot.childrenCount > 0{
                let galleryModelArray = self?.snapshotParser.parseToGallary(snapshot: snapshot)
                completion?(true,galleryModelArray)
            } else{
                completion?(false,nil)
            }
        }
    }
    func loadTeams(startingKey id: String, pageSize limit: Int, completion: ((_ success:Bool,_ teamModelArray: [FCTeamsModel]?)->Void)?){
        rootQuery.child(Constants.TEAMS_PATH_STRING).queryOrderedByKey().queryStarting(atValue: id).queryLimited(toFirst: UInt(limit)).observeSingleEvent(of: .value) { [weak self](snapshot) in
            if snapshot.value != nil && snapshot.childrenCount > 0 {
                let teamsModelArray = self?.snapshotParser.parseToTeams(snapshot: snapshot)
                completion?(true,teamsModelArray)
            } else{
                completion?(false,nil)
            }
        }
    }
    func loadPlayers(startingKey id: String, pageSize limit: Int, completion: ((_ success:Bool,_ playerModelArray: [FCPlayersModel]?)->Void)?){
        rootQuery.child(Constants.PLAYERS_PATH_STRING).queryOrderedByKey().queryStarting(atValue: id).queryLimited(toFirst: UInt(limit)).observeSingleEvent(of: .value) { [weak self](snapshot) in
            if snapshot.value != nil && snapshot.childrenCount > 0 {
                let playersModelArray = self?.snapshotParser.parseToPlayers(snapshot: snapshot)
                completion?(true,playersModelArray)
            } else{
                completion?(false,nil)
            }
        }
    }    
    func removeAllObservers(){
        ref.removeAllObservers()
    }
}
