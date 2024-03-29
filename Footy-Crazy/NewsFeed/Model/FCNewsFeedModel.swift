//
//  FCNewsFeedM.swift
//  Footy-Crazy
//
//  Created by Tintash on 28/06/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

struct FCNewsFeedModel: Decodable {
    
    var url:            String?
    var description:    String?
    var title:          String?
    var type:           FCNewsFeedObjectType?
}

enum FCNewsFeedObjectType: String, Decodable{
    case none
    case video
    case news_link
    case fact
}


