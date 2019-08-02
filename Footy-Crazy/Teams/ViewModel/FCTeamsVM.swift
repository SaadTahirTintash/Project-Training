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
    private var TEAMS_CONSTANTS  : FCConstants.FCTabsConstants
    
    var isFetchingData          : Bool              = false
    var initialDataFetched      : ((Bool)->Void)?
    var newDataFetched          : ((Bool) -> Void)?
    var itemCount: Int{
        return modelArray.count
    }
    init(_ modelArray: [FCTeamsModel]) {
        self.modelArray             = modelArray
        FCConstants.TAB_CONSTANTS   = .teams
        TEAMS_CONSTANTS             = FCConstants.TAB_CONSTANTS.getTabConstants()
    }
}

extension FCTeamsVM: FCTeamsService {
    
    func viewModelForDetail(at index: Int)->FCTeamsDetailVM{
        return FCTeamsDetailVM(modelArray[index])
    }
    
    func getInitialData() {
        
        getTeamData(startingKey: TEAMS_CONSTANTS.STARTING_KEY, pageSize: TEAMS_CONSTANTS.INITIAL_PAGE_SIZE, success: { [weak self](array) in
                self?.dataFetched(isInitialData: true, success: true, array: array)
            }, failure: {[weak self](errorMsg) in
                print(errorMsg)
                self?.dataFetched(isInitialData: true, success: false, array: nil)
            }
        )
    }
    
    func getMoreData() {
        guard !isFetchingData else { return }
        isFetchingData = true
        var startingId = modelArray.endIndex
        if startingId != 0{
            startingId += 1
            getTeamData(startingKey:String(startingId), pageSize: TEAMS_CONSTANTS.PAGE_SIZE, success: { [weak self](array) in
                    self?.dataFetched(isInitialData: false, success: true, array: array)
                }, failure: {  [weak self](errorMsg) in
                    print(errorMsg)
                    self?.dataFetched(isInitialData: false, success: false, array: nil)
            })
        }
    }
    
    func dataFetched(isInitialData:Bool, success: Bool, array: [FCTeamsModel]?) {
        
        if success {
            guard let array = array else { return }
            FCDataManager.shared.addTeamsData(item: array)
            modelArray.append(contentsOf: array)
        }
        isFetchingData = false
        isInitialData ? initialDataFetched?(success) : newDataFetched?(success)
    }
}
