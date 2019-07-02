//
//  FCNetworkEngine.swift
//  Footy-Crazy
//
//  Created by Tintash on 28/06/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

/*
 - Network engine is responsible of getting required data from the server and returning it
 */

import FirebaseDatabase

class NetworkEngine{
    
    let snapshotParser = FCParseSnapshot()
    var ref: DatabaseReference!
    var rootQuery = DatabaseReference()
    init() {
        ref = Database.database().reference()
        rootQuery = ref.child("footy_crazy_data")
    }
    
    //this func takes key id and page size to create a server request and returns a model
    func loadNewsFeed(key id: String, pageSize limit: Int, completion: @escaping(_ success: Bool, _ newsFeedModel: FCNewsFeedModel?)->()){
        rootQuery.child("news_feed").queryOrderedByKey().queryStarting(atValue: id).queryLimited(toFirst: UInt(limit)).observeSingleEvent(of: .value) { [weak self] (snapshot) in
            if snapshot.value != nil && snapshot.childrenCount > 0{
                //we got result from the server
                let newsFeedModel = self?.snapshotParser.parseToNewsFeed(snapshot: snapshot)
                completion(true,newsFeedModel)
            } else{
                //we got error
            }
        }
    }
    
    func removeAllObservers(){
        ref.removeAllObservers()
    }
}
