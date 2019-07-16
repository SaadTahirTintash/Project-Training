//
//  FCTeamsVM.swift
//  Footy-Crazy
//
//  Created by Tintash on 16/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCTeamsVM: FCViewModelProtocol{
    
    private var modelArray: [FCTeamsModel]
    var isFetchingData: Bool = false
    var initialDataCompletionHandler: ((_ success: Bool)->Void)?
    var moreDataCompletionHandler: ((_ success: Bool,_ indexPathArray: [IndexPath]?)->Void)?
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
                self?.initialDataCompletionHandler?(false)
                return
            }
            self?.modelArray.append(contentsOf: array)
            self?.isFetchingData = false
            self?.initialDataCompletionHandler?(true)
        }
    }
    
    func getMoreData(){
        guard !isFetchingData else { return }
        isFetchingData = true
        var startingId = modelArray.last?.id ?? 0
        if startingId != 0{
            startingId += 1
            FCDataManager.shared.getTeams(startingKey: String(startingId), pageSize: Constants.TEAMS_PAGE_SIZE) { [weak self](success, modelArray) in
                guard success, let modelArray = modelArray else{
                    self?.isFetchingData = false
                    self?.moreDataCompletionHandler?(false,nil)
                    return
                }
                self?.modelArray.append(contentsOf: modelArray)
                self?.updateRows(modelArray)
                self?.isFetchingData = false
            }
        }
    }
    
    func updateRows(_ modelArray: [FCTeamsModel]){
        var indexPathsArray = [IndexPath]()
        for obj in modelArray.enumerated(){
            let index = obj.element.id
            let indexPath = IndexPath(row: index - 1, section: 0)
            indexPathsArray.append(indexPath)
        }
        moreDataCompletionHandler?(true,indexPathsArray)

    }
    
}
