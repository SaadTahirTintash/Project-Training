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
            self?.dataFetched(isInitialData: true, success: true, array: array)
        }, failure:  { [weak self] (errorMsg) in
            print(errorMsg)
            self?.dataFetched(isInitialData: true, success: false, array: nil)
        })
    }
    
    func getMoreData(){}
    
    func dataFetched(isInitialData:Bool, success: Bool, array: [FCCitiesLocationModel]?) {
        
        if success {
            guard let array = array else { return }
            FCDataManager.shared.addCitiesLocationData(item: array)
            modelArray.append(contentsOf: array)
        }
        isFetchingData = false
        isInitialData ? initialDataFetched?(success) : newDataFetched?(success)
    }
}
