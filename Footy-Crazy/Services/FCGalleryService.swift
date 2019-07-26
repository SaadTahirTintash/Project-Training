//
//  FCGalleryService.swift
//  Footy-Crazy
//
//  Created by Tintash on 19/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

protocol FCGalleryService: FCNetworkEngine {
    
    typealias successType   = (([FCGalleryModel])->Void)?
    typealias failureType   = ((String)->Void)?
}

extension FCGalleryService {
    
    func getGalleryData(startingKey     id      : String,
                        pageSize        limit   : Int,
                        success                 : successType,
                        failure                 : failureType) {
        
        fetchData(pathString: FCConstants.GALLERY_CONSTANTS.PATH_STRING, startingKey: id, pageSize: limit, success: success, failure: failure)
    }
    
}
