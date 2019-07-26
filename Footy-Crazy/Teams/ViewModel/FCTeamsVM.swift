//
//  FCTeamsVM.swift
//  Footy-Crazy
//
//  Created by Tintash on 16/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCTeamsVM: FCViewModelProtocol {
    
    private var modelArray      : [FCTeamsModel]
    
    var isFetchingData          : Bool              = false
    var initialDataFetched      : ((Bool)->Void)?
    var newDataFetched          : ((Bool) -> Void)?
    var itemCount: Int{
        return modelArray.count
    }
    init(_ modelArray: [FCTeamsModel]) {
        self.modelArray = modelArray
    }
}

extension FCTeamsVM: FCTeamsService {
    
    func viewModelForDetail(at index: Int)->FCTeamsDetailVM{
        return FCTeamsDetailVM(modelArray[index])
    }
    
    func getInitialData() {
        getTeamData(startingKey: FCConstants.TEAMS_CONSTANTS.STARTING_KEY, pageSize: FCConstants.TEAMS_CONSTANTS.INITIAL_PAGE_SIZE, success: { [weak self](array) in
                FCDataManager.shared.addTeamsData(item: array)
                self?.modelArray.append(contentsOf: array)
                self?.isFetchingData = false
                self?.initialDataFetched?(true)
            }, failure: {[weak self](errorMsg) in
                print(errorMsg)
                self?.isFetchingData = false
                self?.initialDataFetched?(false)
            }
        )
    }
    
    func getMoreData() {
        guard !isFetchingData else { return }
        isFetchingData = true
        var startingId = modelArray.endIndex
        if startingId != 0{
            startingId += 1
            getTeamData(startingKey:String(startingId), pageSize: FCConstants.TEAMS_CONSTANTS.PAGE_SIZE, success: { [weak self](array) in
                    FCDataManager.shared.addTeamsData(item: array)
                    self?.modelArray.append(contentsOf: array)
                    self?.isFetchingData = false
                    self?.newDataFetched?(true)
                }, failure: {  [weak self](errorMsg) in
                    print(errorMsg)
                    self?.isFetchingData = false
                    self?.newDataFetched?(false)
            })
        }
    }
}
