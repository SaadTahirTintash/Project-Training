//
//  FCNewsFeedService.swift
//  Footy-Crazy
//
//  Created by Tintash on 19/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

protocol FCNewsFeedService: FCNetworkEngine {
    
    typealias successType   = (([FCNewsFeedModel])->Void)?
    typealias failureType   = ((String)->Void)?
}

extension FCNewsFeedService {
    
    func getNewsFeedData(startingKey    id      : String,
                         pageSize       limit   : Int,
                         success                : successType,
                         failure                : failureType) {
        
        fetchData(pathString: FCConstants.NEWS_FEED_CONSTANTS.PATH_STRING, startingKey: id, pageSize: limit, success: success,failure: failure)
        
    }
}
