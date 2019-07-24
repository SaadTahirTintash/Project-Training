//
//  FCNewsFeedVM.swift
//  Footy-Crazy
//
//  Created by Tintash on 16/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit
class FCNewsFeedVM: FCViewModelProtocol{
    private var modelArray  : [FCNewsFeedModel]
    var isFetchingData      : Bool              = false
    var initialDataFetched  : ((Bool) -> Void)?
    var newDataFetched      : ((Bool) -> Void)?
    var itemCount: Int{
        return modelArray.count
    }
    init(_ modelArray: [FCNewsFeedModel]) {
        self.modelArray = modelArray
    }
}

extension FCNewsFeedVM: FCNewsFeedService{
    func getType(of index: Int)->String?{
        return modelArray[index].type
    }
    func viewModelForDetail(at index: Int)->FCNewsFeedDetailVM{
        return FCNewsFeedDetailVM(modelArray[index])
    }
    func getInitialData() {}    
    func getMoreData() {
        if !isFetchingData{
            isFetchingData = true
            var startingId = modelArray.endIndex
            if startingId != 0{
                startingId += 1
                getNewsFeedData(startingKey: String(startingId), pageSize: FCConstants.NEWS_FEED_CONSTANTS.PAGE_SIZE, success: { [weak self](modelArray) in
                    FCDataManager.shared.newsFeedData.append(contentsOf: modelArray)
                    self?.modelArray.append(contentsOf: modelArray)
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
