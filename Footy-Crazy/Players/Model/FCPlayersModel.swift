//
//  FCPlayerModel.swift
//  Footy-Crazy
//
//  Created by Tintash on 11/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

struct FCPlayersModel: Decodable{
    var standing: String?
    var name: String?
    var country: String?
    var club: String?
    var playerDPUrl: String?
    var description: String?
}
