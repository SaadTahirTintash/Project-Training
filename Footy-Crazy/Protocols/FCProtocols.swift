//
//  FCNewsFeedProtocol.swift
//  Footy-Crazy
//
//  Created by Tintash on 10/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit
protocol FCNewsFeedShareButtonDelegate: class {
    func didPressShareButton(_ newsFeedVM: FCNewsFeedDetailVM?)
}
protocol FCViewModelProtocol: class{
    associatedtype myType
    var isFetchingData      : Bool                          {get set}
    var initialDataFetched  : ((_ success: Bool)->Void)?    {get set}
    var newDataFetched      : ((_ success: Bool)->Void)?    {get set}
    var itemCount           : Int                           {get}
    func getInitialData     ()
    func getMoreData        ()
    func viewModelForDetail (at index: Int)->myType
}