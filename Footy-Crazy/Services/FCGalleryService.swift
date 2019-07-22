//
//  FCGalleryService.swift
//  Footy-Crazy
//
//  Created by Tintash on 19/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

protocol FCGalleryService: FCNetworkEngineProtocol {}
extension FCGalleryService{
    func getGalleryData(startingKey id: String, pageSize limit: Int, completion: ((_ success: Bool, _ galleryModelArray: [FCGalleryModel]?)->Void)?){
        fetchData(pathString: FCConstants.GALLERY_CONSTANTS.PATH_STRING, startingKey: id, pageSize: limit, completion: completion)
    }
}
