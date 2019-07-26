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
    
    var isFetchingData              : Bool              = false
    var initialDataFetched          : ((Bool)->Void)?
    var newDataFetched              : ((Bool)->Void)?
    var itemCount: Int{
        return modelArray.count
    }
    init(_ modelArray: [FCPlayersModel]) {
        self.modelArray = modelArray
    }
}

extension FCPlayersVM: FCPlayersService {
    
    func viewModelForDetail(at index: Int)->FCPlayersDetailVM {
        return FCPlayersDetailVM(modelArray[index])
    }
    
    func getInitialData() {
        getPlayerData(startingKey: FCConstants.PLAYERS_CONSTANTS.STARTING_KEY, pageSize: FCConstants.PLAYERS_CONSTANTS.INITIAL_PAGE_SIZE, success: { [weak self](array) in
            FCDataManager.shared.addPlayersData(item: array)
            self?.modelArray.append(contentsOf: array)
            self?.isFetchingData = false
            self?.initialDataFetched?(true)
        }) { [weak self](errorMsg) in
            print(errorMsg)
            self?.isFetchingData = false
            self?.initialDataFetched?(false)
        }
    }
    
    func getMoreData() {
        if !isFetchingData {
            isFetchingData = true            
            var startingId = modelArray.endIndex
            if startingId != 0 {
                startingId += 1
                getPlayerData(startingKey: String(startingId), pageSize: FCConstants.PLAYERS_CONSTANTS.PAGE_SIZE, success: { [weak self](array) in
                    FCDataManager.shared.addPlayersData(item: array)
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
