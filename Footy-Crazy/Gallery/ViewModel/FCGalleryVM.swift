//
//  FCGalleryVM.swift
//  Footy-Crazy
//
//  Created by Tintash on 15/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCGalleryVM: FCViewModelProtocol{
    
    private var modelArray : [FCGalleryModel]
    var isFetchingData: Bool = false
    var initialDataCompletionHandler: ((_ success: Bool)->Void)?
    var moreDataCompletionHandler: ((_ success: Bool, _ indexPathArray: [IndexPath]?)->Void)?

    init(_ modelArray: [FCGalleryModel]) {
        self.modelArray = modelArray
    }
    
    var itemCount: Int{
        return modelArray.count
    }
    
    func viewModelForDetail(at index: Int) -> FCGalleryDetailVM {
        return FCGalleryDetailVM(model: modelArray[index])
    }
    
    func getInitialData(){
        FCDataManager.shared.getGallery(startingKey: Constants.GALLERY_STARTING_KEY, pageSize: Constants.GALLERY_INITIAL_PAGE_SIZE){[weak self](success, modelArray) in
            guard success, let array = modelArray else{
                self?.isFetchingData = false
                self?.initialDataCompletionHandler?(false)
                return
            }
            self?.modelArray.append(contentsOf: array)
            self?.isFetchingData = false
            self?.initialDataCompletionHandler?(true)
        }
    }
    
    func getMoreData(){
        if !isFetchingData{
            isFetchingData = true
            var startingId = modelArray.last?.id ?? 0
            if startingId != 0{
                startingId += 1
                FCDataManager.shared.getGallery(startingKey: String(startingId), pageSize: Constants.GALLERY_PAGE_SIZE) { [weak self](success, modelArray) in
                    guard success, let modelArray = modelArray else{
                        self?.isFetchingData = false
                        self?.moreDataCompletionHandler?(false, nil)
                        return
                    }
                    self?.modelArray.append(contentsOf: modelArray)
                    self?.isFetchingData = false
                    self?.updateRows(modelArray)
                }
            }
        }
    }
    
    func updateRows(_ modelArray: [FCGalleryModel]){
        var indexPathsArray = [IndexPath]()
        for obj in modelArray.enumerated(){
            let index = obj.element.id
            let indexPath = IndexPath(row: index - 1, section: 0)
            indexPathsArray.append(indexPath)
        }
        moreDataCompletionHandler?(true,indexPathsArray)
    }
    
}
