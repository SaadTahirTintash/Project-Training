//
//  FCNewsFeedCellProtocol.swift
//  Footy-Crazy
//
//  Created by Tintash on 25/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import Foundation
import UIKit

//MARK:- Definition
protocol FCNewsFeedCellProtocol {
    
    //MARK:- Generic type
    associatedtype view_model
    
    //MARK:- Properties
    var viewModel       : view_model?               { get set }
    var shareBtnPressed : ((view_model?)->Void)?    { get set }
    
    //MARK:- Methods
    func configure()
}
