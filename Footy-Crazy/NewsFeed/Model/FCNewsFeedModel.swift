//
//  FCNewsFeedM.swift
//  Footy-Crazy
//
//  Created by Tintash on 28/06/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

struct FCNewsFeedModel: Decodable{
    var url:            String?
    var description:    String?
    var title:          String?
    var type:           String?
    //Code Review: use Enum for the type and add all the casses in that enum
}
