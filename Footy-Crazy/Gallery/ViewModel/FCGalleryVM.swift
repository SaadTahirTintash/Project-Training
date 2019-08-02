//
//  FCGalleryVM.swift
//  Footy-Crazy
//
//  Created by Tintash on 15/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCGalleryVM: FCViewModelProtocol {
    
    //MARK:- Private Properties
    private var modelArray          : [FCGalleryModel]
    private var GALLERY_CONSTANTS   : FCConstants.FCTabsConstants
    
    //MARK:- Public Properties
    var isFetchingData      : Bool = false
    var initialDataFetched  : ((Bool)->Void)?
    var newDataFetched      : ((Bool)->Void)?
    
    //MARK:- Computed Properties
    var itemCount: Int{
        return modelArray.count
    }
    
    //MARK:- Initialization
    init(_ modelArray: [FCGalleryModel]) {
        self.modelArray                 = modelArray
        FCConstants.TAB_CONSTANTS       = .gallery
        GALLERY_CONSTANTS               = FCConstants.TAB_CONSTANTS.getTabConstants()
    }
    
    //MARK:- Methods
    func viewModelForDetail(at index: Int) -> FCGalleryDetailVM {
        return FCGalleryDetailVM(model: modelArray[index])
    }
}

//MARK:- Service
extension FCGalleryVM: FCGalleryService {
    
    func getInitialData() {
        getGalleryData(startingKey: GALLERY_CONSTANTS.STARTING_KEY, pageSize: GALLERY_CONSTANTS.INITIAL_PAGE_SIZE, success: { [weak self](array) in
            
            self?.dataFetched(isInitialData: true, success: true, array: array)
            
        }) { [weak self](errorMsg) in
            
            print(errorMsg)
            self?.dataFetched(isInitialData: true, success: false, array: nil)
        }
    }
    
    func getMoreData() {
        if !isFetchingData {
            isFetchingData = true
            var startingId = modelArray.endIndex
            if startingId != 0 {
                startingId += 1
                getGalleryData(startingKey: String(startingId), pageSize: GALLERY_CONSTANTS.PAGE_SIZE, success: { [weak self](array) in
                    
                    self?.dataFetched(isInitialData: false, success: true, array: array)
                    
                }) { [weak self](errorMsg) in
                    
                    print(errorMsg)
                    self?.dataFetched(isInitialData: false, success: false, array: nil)
                }
            }
        }
    }
    
    func dataFetched(isInitialData:Bool, success: Bool, array: [FCGalleryModel]?) {
        
        if success {
            guard let array = array else { return }
            FCDataManager.shared.addGalleryData(item: array)
            modelArray.append(contentsOf: array)
        }
        isFetchingData = false
        isInitialData ? initialDataFetched?(success) : newDataFetched?(success)
    }
    
}
