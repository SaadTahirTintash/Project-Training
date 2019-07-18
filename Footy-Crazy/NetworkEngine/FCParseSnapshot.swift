//
//  FCParseSnapshot.swift
//  Footy-Crazy
//
//  Created by Tintash on 01/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import FirebaseDatabase
import SwiftyJSON
import Alamofire

class FCParseSnapshot{
    func parseToNewsFeed(snapshot: DataSnapshot)->[FCNewsFeedModel]{
        var newsFeedModelArray = [FCNewsFeedModel]()
        let enumerator = snapshot.children
        while let snap = enumerator.nextObject() as? DataSnapshot{
            do{
                if let value = snap.value as? [String: Any]{
                    let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(FCNewsFeedModel.self, from: jsonData)
                    newsFeedModelArray.append(model)
                }
            }catch{
                print("Whoops! An error occured while decoding NewsFeed: \(error.localizedDescription)")
            }
        }
        return newsFeedModelArray
    }
    func parseToGallary(snapshot: DataSnapshot)->[FCGalleryModel]{
        var galleryModelArray = [FCGalleryModel]()
        let enumerator = snapshot.children
        while let snap = enumerator.nextObject() as? DataSnapshot{
            let galleryModel = FCGalleryModel(imageUrl: snap.value as? String)
            galleryModelArray.append(galleryModel)
        }
        return galleryModelArray
    }
    func parseToTeams(snapshot: DataSnapshot)->[FCTeamsModel]{
        var teamsModelArray = [FCTeamsModel]()
        let enumerator = snapshot.children
        while let snap = enumerator.nextObject() as? DataSnapshot{
            do {
                if let value = snap.value as? [String: Any]{
                    let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(FCTeamsModel.self, from: jsonData)
                    teamsModelArray.append(model)
                }
            }catch{
                print("Whoops! An error occured while decoding Teams: \(error.localizedDescription)")
            }
        }
        return teamsModelArray
    }    
    func parseToPlayers(snapshot: DataSnapshot)->[FCPlayersModel]{
        var playersModelArray = [FCPlayersModel]()
        let enumerator = snapshot.children
        while let snap = enumerator.nextObject() as? DataSnapshot{
            do {
                if let value = snap.value as? [String: Any]{
                    let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(FCPlayersModel.self, from: jsonData)
                    playersModelArray.append(model)
                }
            }catch{
                print("Whoops! An error occured while decoding Players: \(error.localizedDescription)")
            }
        }
        return playersModelArray
    }
    
    func parseToCitiesLocation(value: Any)->[FCCitiesLocationModel]?{
        var citiesLocationModelArray = [FCCitiesLocationModel]()
        guard let dataArray = value as? [[String:Any]] else{
            return nil
        }
        for data in dataArray{
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                let decoder = JSONDecoder()
                let data = try decoder.decode(FCCitiesLocationModel.self, from: jsonData)
                citiesLocationModelArray.append(data)
            }catch{
                print(error.localizedDescription)
            }
        }
        return citiesLocationModelArray
    }
    
}
