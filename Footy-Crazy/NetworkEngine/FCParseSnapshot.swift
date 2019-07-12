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
                let newsFeedModel = FCNewsFeedModel(id: Int(snap.key) ?? 0,url: value["url"] as? String, description: value["description"] as? String, title: value["title"] as? String, type: value["type"] as? String, image: nil)
                newsFeedModelArray.append(newsFeedModel)
            }
        }
        return newsFeedModelArray
    }
    
    func parseToGallary(snapshot: DataSnapshot)->[FCGalleryModel]{
        var galleryModelArray = [FCGalleryModel]()
        let enumerator = snapshot.children
        while let snap = enumerator.nextObject() as? DataSnapshot{
            let galleryModel = FCGalleryModel(id: Int(snap.key) ?? 0, imageUrl: snap.value as? String ?? nil, image: nil)
            galleryModelArray.append(galleryModel)
        }
        return galleryModelArray
    }
    
    func parseToTeams(snapshot: DataSnapshot)->[FCTeamsModel]{
        var teamsModelArray = [FCTeamsModel]()
        let enumerator = snapshot.children
        while let snap = enumerator.nextObject() as? DataSnapshot{
            if let value = snap.value as? [String: Any]{
                let teamsModel = FCTeamsModel(id: Int(snap.key) ?? 0, name: value["name"] as? String, standing: value["standing"] as? String, country: value["country"] as? String, flag: nil, flagUrl: value["flagUrl"] as? String, description: value["description"] as? String)
                teamsModelArray.append(teamsModel)
            }
        }
        return teamsModelArray
    }
    
    func parseToPlayers(snapshot: DataSnapshot)->[FCPlayersModel]{
        var playersModelArray = [FCPlayersModel]()
        let enumerator = snapshot.children
        while let snap = enumerator.nextObject() as? DataSnapshot{
            if let value = snap.value as? [String: Any]{
                let playersModel = FCPlayersModel(id: Int(snap.key) ?? 0, standing: value["standing"] as? String, name: value["name"] as? String, country: value["country"] as? String, club: value["club"] as? String, playerDP: nil, playerDPUrl: value["playerDPUrl"] as? String, description: value["description"] as? String)
                playersModelArray.append(playersModel)
            }
        }
        return playersModelArray
    }

}
