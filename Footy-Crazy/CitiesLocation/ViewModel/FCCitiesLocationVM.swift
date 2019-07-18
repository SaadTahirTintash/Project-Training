//
//  FCCitiesLocationVM.swift
//  Footy-Crazy
//
//  Created by Tintash on 18/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import Foundation

class FCCitiesLocationVM: FCViewModelProtocol{
    private var modelArray: [FCCitiesLocationModel]
    var isFetchingData      : Bool                          = false
    var initialDataFetched  : ((_ success: Bool)->Void)?
    var newDataFetched      : ((_ success: Bool)->Void)?
    var itemCount           : Int                           {return modelArray.count}
    init(_ modelArray: [FCCitiesLocationModel]) {
        self.modelArray = modelArray
    }
    func viewModelForDetail (at index: Int)->FCCitiesLocationDetailVM{
        return FCCitiesLocationDetailVM(modelArray[index])
    }
    func getInitialData(){
        FCDataManager.shared.getCitiesLocation { [weak self](success, modelArray) in
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
        
    }
}
