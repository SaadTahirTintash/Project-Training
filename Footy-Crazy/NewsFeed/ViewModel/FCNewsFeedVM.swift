//
//  FCNewsFeedVM.swift
//  Footy-Crazy
//
//  Created by Tintash on 16/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCNewsFeedVM: FCViewModelProtocol{
    
    private var modelArray: [FCNewsFeedModel]
    var isFetchingData: Bool = false
    var initialDataCompletionHandler: ((Bool) -> Void)?
    var moreDataCompletionHandler: ((Bool, [IndexPath]?) -> Void)?
    
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
    
    func getInitialData() {
        //no need
    }
    
    func getMoreData() {
        if !isFetchingData{
            isFetchingData = true
            var startingId = modelArray.last?.id ?? 0
            if startingId != 0{
                startingId += 1
                FCDataManager.shared.getNewsFeed(startingKey: String(startingId), pageSize: Constants.NEWS_FEED_PAGE_SIZE) { [weak self] (success,modelArray) in
                    if success{
                        guard success, let modelArray = modelArray else{
                            self?.isFetchingData = false
                            self?.moreDataCompletionHandler?(false,nil)
                            return
                        }
                        self?.modelArray.append(contentsOf: modelArray)
                        self?.updateTableRows(modelArray)
                        self?.isFetchingData = false
                    }
                }
            }
        }
    }
    
    func updateTableRows(_ modelArray: [FCNewsFeedModel]){
        var indexPathsArray = [IndexPath]()
        for obj in modelArray.enumerated(){
            let index = obj.element.id
            let indexPath = IndexPath(row: index - 1, section: 0)
            indexPathsArray.append(indexPath)
        }
        moreDataCompletionHandler?(true,indexPathsArray)
    }
    
    
}
