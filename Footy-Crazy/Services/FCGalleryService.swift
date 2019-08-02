//
//  FCGalleryService.swift
//  Footy-Crazy
//
//  Created by Tintash on 19/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

//MARK:- Definition
protocol FCGalleryService: FCNetworkEngine {
    
    typealias successType   = (([FCGalleryModel])->Void)?
    typealias failureType   = ((String)->Void)?
}

//MARK:- Extension
extension FCGalleryService {
    
    //MARK:- Methods
    /// Fetch data from network engine protocol using the required parameters
    ///
    /// - Parameters:
    ///   - id: key to start fetching from
    ///   - limit: window to fetch
    ///   - success: completion handler for success
    ///   - failure: completion handler for failure
    func getGalleryData(startingKey     id      : String,
                        pageSize        limit   : Int,
                        success                 : successType,
                        failure                 : failureType) {
        
        FCConstants.TAB_CONSTANTS   = .gallery
        let GALLERY_CONSTANTS       = FCConstants.TAB_CONSTANTS.getTabConstants()
        
        fetchData(pathString: GALLERY_CONSTANTS.PATH_STRING, startingKey: id, pageSize: limit, success: success, failure: failure)
    }
    
}
