//
//  FCCitiesLocationService.swift
//  Footy-Crazy
//
//  Created by Tintash on 19/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

protocol FCCitiesLocationService: FCNetworkEngine {}
extension FCCitiesLocationService{
    func getCitiesLocationData(pathString: String, queryString: String, completion: ((_ success: Bool, _ citiesLocationModelArray: [FCCitiesLocationModel]?)->Void)?){
        fetchAPI(pathString: pathString, query: queryString, completion: completion)
    }
}
