//
//  FCParseSnapshot.swift
//  Footy-Crazy
//
//  Created by Tintash on 01/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import FirebaseDatabase

class FCParseSnapshot{
    
    func parseToNewsFeed(snapshot: DataSnapshot)->NewsFeedM{
        var newsFeedObject = NewsFeedM()
        let enumerator = snapshot.children
        while let snap = enumerator.nextObject() as? DataSnapshot{
            if let value = snap.value as? [String: Any]{
                switch value["type"] as? String{
                case "video":
                    let video = VideoM(url: value["url"] as? String ?? "", title: value["title"] as? String ?? "", description: value["description"] as? String ?? "")
                    newsFeedObject.object?.append(video as VideoM)
                case "news_link":
                    let newsLink = NewsLinkM(url: value["url"] as? String ?? "", title: value["title"] as? String ?? "", description: value["description"] as? String ?? "")
                    newsFeedObject.object?.append(newsLink as NewsLinkM)
                default:
                    let fact = FactM(imageUrl: value["url"] as? String ?? "", title: value["title"] as? String ?? "", fact: value["description"] as? String ?? "")
                    newsFeedObject.object?.append(fact as FactM
                    )
                }                
            }
        }
        return newsFeedObject
    }
}
