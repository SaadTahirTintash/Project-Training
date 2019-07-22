//
//  FCNewsFeedService.swift
//  Footy-Crazy
//
//  Created by Tintash on 19/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

protocol FCNewsFeedService: FCNetworkEngineProtocol {}
extension FCNewsFeedService{
    func getNewsFeedData(startingKey id: String, pageSize limit: Int, completion: ((_ success: Bool, _ newsFeedModelArray: [FCNewsFeedModel]?)->Void)?){
        fetchData(pathString: FCConstants.NEWS_FEED_CONSTANTS.PATH_STRING, startingKey: id, pageSize: limit, completion: completion)
        
    }
}
