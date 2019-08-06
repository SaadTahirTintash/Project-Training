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
//Code Review: Instead of write method in one line split into multiple lines to make it readable (like you do in networkEngine class for method fetchData ).
extension FCNewsFeedService{
    func getNewsFeedData(startingKey id: String, pageSize limit: Int, success: successType, failure: failureType){
        fetchData(pathString: FCConstants.NEWS_FEED_CONSTANTS.PATH_STRING, startingKey: id, pageSize: limit, success: success,failure: failure)
        
    }
}
