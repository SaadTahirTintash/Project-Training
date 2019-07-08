//
//  FCParseSnapshot.swift
//  Footy-Crazy
//
//  Created by Tintash on 01/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import FirebaseDatabase

class FCParseSnapshot{
    
    func parseToNewsFeed(snapshot: DataSnapshot)->FCNewsFeedModel{
        var newsFeedObject = FCNewsFeedModel()
        let enumerator = snapshot.children
        while let snap = enumerator.nextObject() as? DataSnapshot{
            if let value = snap.value as? [String: Any]{
                let id = snap.key
                switch value["type"] as? String{
                case "video":
                    let video = FCVideoModel(id: id,url: value["url"] as? String ?? "", title: value["title"] as? String ?? "", description: value["description"] as? String ?? "")
                    newsFeedObject.objects?.append(video as FCVideoModel)
                case "news_link":
                    let newsLink = FCNewsLinkModel(id: id,url: value["url"] as? String ?? "", title: value["title"] as? String ?? "", description: value["description"] as? String ?? "")
                    newsFeedObject.objects?.append(newsLink as FCNewsLinkModel)
                default:
                    let fact = FCFactModel(id: id,imageUrl: value["imageUrl"] as? String ?? "", title: value["title"] as? String ?? "", fact: value["fact"] as? String ?? "")
                    newsFeedObject.objects?.append(fact as FCFactModel
                    )
                }                
            }
        }
        return newsFeedObject
    }
}
