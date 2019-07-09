//
//  FCParseSnapshot.swift
//  Footy-Crazy
//
//  Created by Tintash on 01/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import FirebaseDatabase

class FCParseSnapshot{
    
    func parseToNewsFeed(snapshot: DataSnapshot)->[FCNewsFeedModel]{
        var newsFeedModelArray = [FCNewsFeedModel]()
        let enumerator = snapshot.children
        while let snap = enumerator.nextObject() as? DataSnapshot{
            if let value = snap.value as? [String: Any]{
                let newsFeedModel = FCNewsFeedModel(id: snap.key,url: value["url"] as? String ?? "", description: value["description"] as? String ?? "", title: value["title"] as? String ?? "", type: value["type"] as? String ?? "", image: Constants.EMPTY_IMAGE)
                newsFeedModelArray.append(newsFeedModel)
            }
        }
        return newsFeedModelArray
    }
}
