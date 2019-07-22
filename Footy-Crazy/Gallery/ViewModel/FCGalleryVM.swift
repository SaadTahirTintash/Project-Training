//
//  FCGalleryVM.swift
//  Footy-Crazy
//
//  Created by Tintash on 15/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCGalleryVM: FCViewModelProtocol{
    private var modelArray  : [FCGalleryModel]
    var isFetchingData      : Bool = false
    var initialDataFetched  : ((Bool)->Void)?
    var newDataFetched      : ((Bool)->Void)?
    var itemCount: Int{
        return modelArray.count
    }
    init(_ modelArray: [FCGalleryModel]) {
        self.modelArray = modelArray
    }
}
extension FCGalleryVM: FCGalleryService{
    func viewModelForDetail(at index: Int) -> FCGalleryDetailVM {
        return FCGalleryDetailVM(model: modelArray[index])
    }
    func getInitialData(){
        getGalleryData(startingKey: FCConstants.GALLERY_CONSTANTS.STARTING_KEY, pageSize: FCConstants.GALLERY_CONSTANTS.INITIAL_PAGE_SIZE, success: { [weak self](array) in
            FCDataManager.shared.galleryData.append(contentsOf: array)
            self?.modelArray.append(contentsOf: array)
            self?.isFetchingData = false
            self?.initialDataFetched?(true)
        }) { [weak self](errorMsg) in
            print(errorMsg)
            self?.isFetchingData = false
            self?.initialDataFetched?(false)
        }
    }    
    func getMoreData(){
        if !isFetchingData{
            isFetchingData = true
            var startingId = modelArray.endIndex
            if startingId != 0{
                startingId += 1
                getGalleryData(startingKey: String(startingId), pageSize: FCConstants.GALLERY_CONSTANTS.PAGE_SIZE, success: { [weak self](array) in
                    FCDataManager.shared.galleryData.append(contentsOf: array)
                    self?.modelArray.append(contentsOf: array)
                    self?.isFetchingData = false
                    self?.newDataFetched?(true)
                }) { [weak self](errorMsg) in
                    print(errorMsg)
                    self?.isFetchingData = false
                    self?.newDataFetched?(false)
                }
            }
        }
    }
}
