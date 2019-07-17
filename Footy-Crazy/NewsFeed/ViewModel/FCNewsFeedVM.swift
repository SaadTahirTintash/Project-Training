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

    init(_ modelArray: [FCNewsFeedModel]) {
        self.modelArray = modelArray
    }
    var itemCount: Int{
        return modelArray.count
    }
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
                FCDataManager.shared.getNewsFeed(startingKey: String(startingId), pageSize: Constants.NEWS_FEED_PAGE_SIZE) { [weak self] (success,modelArray) in
                    if success{
                        guard success, let modelArray = modelArray else{
                            self?.isFetchingData = false
                            self?.newDataFetched?(false)
                            return
                        }
                        self?.modelArray.append(contentsOf: modelArray)
                        self?.isFetchingData = false
                        self?.newDataFetched?(true)
                    }
                }
            }
        }
    }    
}
