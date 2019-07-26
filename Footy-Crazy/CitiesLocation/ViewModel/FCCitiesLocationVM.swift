//
//  FCCitiesLocationVM.swift
//  Footy-Crazy
//
//  Created by Tintash on 18/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import Foundation

class FCCitiesLocationVM: FCViewModelProtocol {

    private var modelArray: [FCCitiesLocationModel]

    var isFetchingData      : Bool                          = false
    var initialDataFetched  : ((_ success: Bool)->Void)?
    var newDataFetched      : ((_ success: Bool)->Void)?
    var itemCount           : Int                           {return modelArray.count}

    init(_ modelArray: [FCCitiesLocationModel]) {
        self.modelArray = modelArray
    }
}

extension FCCitiesLocationVM: FCCitiesLocationService {
    
    func viewModelForDetail (at index: Int)->FCCitiesLocationDetailVM {
        return FCCitiesLocationDetailVM(modelArray[index])
    }
    
    func getInitialData() {
        getCitiesLocationData(pathString: FCConstants.CITIES_LOCATION_CONSTANTS.PATH_STRING, queryString: FCConstants.CITIES_LOCATION_CONSTANTS.QUERY_STRING, success: { [weak self] (array) in
            FCDataManager.shared.addCitiesLocationData(item: array)
            self?.modelArray.append(contentsOf: array)
            self?.isFetchingData = false
            self?.initialDataFetched?(true)
        }, failure:  { [weak self] (errorMsg) in
            print(errorMsg)
            self?.isFetchingData = false
            self?.initialDataFetched?(false)
        })
    }
    
    func getMoreData(){}
}
