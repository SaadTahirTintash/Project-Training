//
//  FCNewsFeedVM.swift
//  Footy-Crazy
//
//  Created by Tintash on 16/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCNewsFeedVM: FCViewModelProtocol {
    
    //MARK:- Private Properties
    private var modelArray          : [FCNewsFeedModel]
    private var NEWS_FEED_CONSTANTS : FCConstants.FCTabsConstants
    
    //MARK:- Public Properties
    var isFetchingData      : Bool              = false
    var initialDataFetched  : ((Bool) -> Void)?
    var newDataFetched      : ((Bool) -> Void)?
    var itemCount: Int{
        return modelArray.count
    }
    
    //MARK:- Initialization
    init(_ modelArray: [FCNewsFeedModel]) {
        self.modelArray                 = modelArray
        FCConstants.TAB_CONSTANTS       = .newsFeed
        NEWS_FEED_CONSTANTS             = FCConstants.TAB_CONSTANTS.getTabConstants()
        
    }
    
    //Methods
    func getType(of index: Int)->FCNewsFeedObjectType? {
        return modelArray[index].type
    }
    
    func viewModelForDetail(at index: Int)->FCNewsFeedDetailVM {
        return FCNewsFeedDetailVM(modelArray[index])
    }
}

//MARK:- Service Methods
extension FCNewsFeedVM: FCNewsFeedService {
    
    func getInitialData() {}
    
    func getMoreData() {
        if !isFetchingData {
            isFetchingData = true
            var startingId = modelArray.endIndex
            if startingId != 0 {
                startingId += 1
                getNewsFeedData(startingKey: String(startingId), pageSize: NEWS_FEED_CONSTANTS.PAGE_SIZE, success: { [weak self](array) in
                    self?.dataFetched(isInitialData: false, success: true, array: array)
                }) { [weak self](errorMsg) in
                    print(errorMsg)
                    self?.dataFetched(isInitialData: false, success: false, array: nil)
                }
            }
        }
    }
    
    func dataFetched(isInitialData:Bool, success: Bool, array: [FCNewsFeedModel]?) {
        
        if success {
            guard let array = array else { return }
            FCDataManager.shared.addNewsFeedData(item: array)
            modelArray.append(contentsOf: array)
        }
        isFetchingData = false
        isInitialData ? initialDataFetched?(success) : newDataFetched?(success)
    }
    
}
