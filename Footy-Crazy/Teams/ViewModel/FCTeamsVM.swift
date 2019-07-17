//
//  FCTeamsVM.swift
//  Footy-Crazy
//
//  Created by Tintash on 16/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit
class FCTeamsVM: FCViewModelProtocol{
    private var modelArray      : [FCTeamsModel]
    var isFetchingData          : Bool              = false
    var initialDataFetched      : ((Bool)->Void)?
    var newDataFetched          : ((Bool) -> Void)?
    init(_ modelArray: [FCTeamsModel]) {
        self.modelArray = modelArray
    }
    var itemCount: Int{
        return modelArray.count
    }
    func viewModelForDetail(at index: Int)->FCTeamsDetailVM{
        return FCTeamsDetailVM(modelArray[index])
    }
    func getInitialData(){
        FCDataManager.shared.getTeams(startingKey: Constants.TEAMS_STARTING_KEY,
                                      pageSize: Constants.TEAMS_INITIAL_PAGE_SIZE) {[weak self](success, modelArray) in
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
        guard !isFetchingData else { return }
        isFetchingData = true
        var startingId = modelArray.endIndex
        if startingId != 0{
            startingId += 1
            FCDataManager.shared.getTeams(startingKey: String(startingId), pageSize: Constants.TEAMS_PAGE_SIZE) { [weak self](success, modelArray) in
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
