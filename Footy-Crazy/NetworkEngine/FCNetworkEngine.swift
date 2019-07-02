//
//  FCNetworkEngine.swift
//  Footy-Crazy
//
//  Created by Tintash on 28/06/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import FirebaseDatabase

class NetworkEngine{
    
    let snapshotParser = FCParseSnapshot()
    var ref: DatabaseReference!
    var newsFeedObserver = UInt(0)
    
    init() {
        ref = Database.database().reference()
    }
    
    func loadNewsFeedOnce(completion: @escaping (_ success: Bool, _ newsFeedObject: NewsFeedM?) -> Void){        
            ref.child("footy_crazy_data").child("news_feed").observeSingleEvent(of: .value, with: { (snapshot) in
                if snapshot.value != nil{
                    completion(true, self.snapshotParser.parseToNewsFeed(snapshot: snapshot))
                }
            })
    }
    
    func loadNewsFeed(count: Int, completion: @escaping (_ success: Bool, _ newsFeedObject: NewsFeedM?) -> Void){
        
        newsFeedObserver = ref.child("footy_crazy_data").child("news_feed").observe(.value, with: { (snapshot) in
            if snapshot.value != nil{
                completion(true, self.snapshotParser.parseToNewsFeed(snapshot: snapshot))
            }
        })        
    }
    
    func removeNewsFeedObserver(){
        ref.removeObserver(withHandle: newsFeedObserver)
    }    
    
    func removeAllObservers(){
        ref.removeAllObservers()
    }
}
