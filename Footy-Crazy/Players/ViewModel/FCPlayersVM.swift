//
//  FCPlayersVM.swift
//  Footy-Crazy
//
//  Created by Tintash on 16/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCPlayersVM: FCViewModelProtocol {
    
    private var modelArray          : [FCPlayersModel]
    private var PLAYERS_CONSTANTS   : FCConstants.FCTabsConstants
    
    var isFetchingData              : Bool              = false
    var initialDataFetched          : ((Bool)->Void)?
    var newDataFetched              : ((Bool)->Void)?
    var itemCount: Int{
        return modelArray.count
    }
    init(_ modelArray: [FCPlayersModel]) {
        self.modelArray                 = modelArray
        FCConstants.TAB_CONSTANTS       = .players
        PLAYERS_CONSTANTS               = FCConstants.TAB_CONSTANTS.getTabConstants()
    }
}

extension FCPlayersVM: FCPlayersService {
    
    func viewModelForDetail(at index: Int)->FCPlayersDetailVM {
        return FCPlayersDetailVM(modelArray[index])
    }
    
    func getInitialData() {
        getPlayerData(startingKey: PLAYERS_CONSTANTS.STARTING_KEY, pageSize: PLAYERS_CONSTANTS.INITIAL_PAGE_SIZE, success: { [weak self](array) in
            self?.dataFetched(isInitialData: true, success: true, array: array)
        }) { [weak self](errorMsg) in
            print(errorMsg)
            self?.dataFetched(isInitialData: true, success: false, array: nil)
        }
    }
    
    func getMoreData() {
        if !isFetchingData {
            isFetchingData = true            
            var startingId = modelArray.endIndex
            if startingId != 0 {
                startingId += 1
                getPlayerData(startingKey: String(startingId), pageSize: PLAYERS_CONSTANTS.PAGE_SIZE, success: { [weak self](array) in
                    self?.dataFetched(isInitialData: false, success: true, array: array)
                }) { [weak self](errorMsg) in
                    print(errorMsg)
                    self?.dataFetched(isInitialData: false, success: false, array: nil)
                }
            }
        }
    }
    
    func dataFetched(isInitialData:Bool, success: Bool, array: [FCPlayersModel]?) {
        
        if success {
            guard let array = array else { return }
            FCDataManager.shared.addPlayersData(item: array)
            modelArray.append(contentsOf: array)
        }
        isFetchingData = false
        isInitialData ? initialDataFetched?(success) : newDataFetched?(success)
    }
}
