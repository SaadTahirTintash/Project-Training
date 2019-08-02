//
//  FCNewsFeedVM.swift
//  Footy-Crazy
//
//  Created by Tintash on 16/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

enum FCNewsFeedObjectType: Int{
    case Default = 0
    case Video
    case NewsLink
    case Fact
}

class FCNewsFeedVM: FCViewModelProtocol {
    
    private var modelArray          : [FCNewsFeedModel]
    private var NEWS_FEED_CONSTANTS : FCConstants.FCTabsConstants
    
    var isFetchingData      : Bool              = false
    var initialDataFetched  : ((Bool) -> Void)?
    var newDataFetched      : ((Bool) -> Void)?
    var itemCount: Int{
        return modelArray.count
    }
    
    init(_ modelArray: [FCNewsFeedModel]) {
        self.modelArray                 = modelArray
        FCConstants.TAB_CONSTANTS       = .newsFeed
        NEWS_FEED_CONSTANTS             = FCConstants.TAB_CONSTANTS.getTabConstants()
        
    }
}

extension FCNewsFeedVM: FCNewsFeedService {
    
    func getType(of index: Int)->FCNewsFeedObjectType {
        switch modelArray[index].type {
        case "video":
            return FCNewsFeedObjectType.Video
        case "fact":
            return FCNewsFeedObjectType.Fact
        case "news_link":
            return FCNewsFeedObjectType.NewsLink
        default:
            return FCNewsFeedObjectType.Default
        }
    }
    
    func viewModelForDetail(at index: Int)->FCNewsFeedDetailVM {
        return FCNewsFeedDetailVM(modelArray[index])
    }
    
    func getInitialData() {}
    
    func getMoreData() {
        if !isFetchingData {
            isFetchingData = true
            var startingId = modelArray.endIndex
            if startingId != 0 {
                startingId += 1
                getNewsFeedData(startingKey: String(startingId), pageSize: NEWS_FEED_CONSTANTS.PAGE_SIZE, success: { [weak self](array) in
                    FCDataManager.shared.addNewsFeedData(item: array)
                    self?.modelArray.append(contentsOf: array)
                    self?.isFetchingData = false
                    self?.newDataFetched?(true)
                }) { [weak self](errorMsg) in
                    print(errorMsg)
                    self?.isFetchingData = false
                    self?.newDataFetched?(false)
                }
            }
        }
    }
}
