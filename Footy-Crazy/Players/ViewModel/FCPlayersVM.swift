//
//  FCPlayersVM.swift
//  Footy-Crazy
//
//  Created by Tintash on 16/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCPlayersVM: FCViewModelProtocol{
    private var modelArray          : [FCPlayersModel]
    var isFetchingData              : Bool              = false
    var initialDataFetched          : ((Bool)->Void)?
    var newDataFetched              : ((Bool)->Void)?
    
    init(_ modelArray: [FCPlayersModel]) {
        self.modelArray = modelArray
    }
    
    var itemCount: Int{
        return modelArray.count
    }
    
    func viewModelForDetail(at index: Int)->FCPlayersDetailVM{
        return FCPlayersDetailVM(modelArray[index])
    }
    
    func getInitialData(){
        FCDataManager.shared.getPlayers(startingKey: Constants.PLAYERS_STARTING_KEY, pageSize: Constants.PLAYERS_INITIAL_PAGE_SIZE){[weak self](success, modelArray) in
            guard success, let array = modelArray else{
                self?.isFetchingData = false
                self?.initialDataFetched?(false)
                return
            }
            self?.modelArray.append(contentsOf: array)
            self?.isFetchingData = false
            self?.initialDataFetched?(true)
        }
    }
    
    func getMoreData(){
        if !isFetchingData{
            isFetchingData = true            
            var startingId = modelArray.endIndex
            if startingId != 0{
                startingId += 1
                FCDataManager.shared.getPlayers(startingKey: String(startingId), pageSize: Constants.PLAYERS_PAGE_SIZE) { [weak self](success, modelArray) in
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
