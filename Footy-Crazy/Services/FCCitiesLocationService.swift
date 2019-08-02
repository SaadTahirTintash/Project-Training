//
//  FCCitiesLocationService.swift
//  Footy-Crazy
//
//  Created by Tintash on 19/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

//MARK:- Definition
protocol FCCitiesLocationService: FCNetworkEngine {
    
    typealias successType   = (([FCCitiesLocationModel])->Void)?
    typealias failureType   = ((String)->Void)?
}

//MARK:- Extension
extension FCCitiesLocationService {
    
    //MARK:- Methods
    /// Fetch data from network engine protocol using the required parameters
    ///
    /// - Parameters:
    ///   - id: key to start fetching from
    ///   - limit: window to fetch
    ///   - success: completion handler for success
    ///   - failure: completion handler for failure
    func getCitiesLocationData(pathString   : String,
                               queryString  : String,
                               success      : successType,
                               failure      : failureType) {
        
        fetchAPI(pathString: pathString, query: queryString, success: success, failure: failure)
    }
}
