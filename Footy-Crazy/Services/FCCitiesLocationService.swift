//
//  FCCitiesLocationService.swift
//  Footy-Crazy
//
//  Created by Tintash on 19/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

protocol FCCitiesLocationService: FCNetworkEngine {
    
    typealias successType   = (([FCCitiesLocationModel])->Void)?
    typealias failureType   = ((String)->Void)?
}

extension FCCitiesLocationService {
    
    func getCitiesLocationData(pathString   : String,
                               queryString  : String,
                               success      : successType,
                               failure      : failureType) {
        
        fetchAPI(pathString: pathString, query: queryString, success: success, failure: failure)
    }
}
