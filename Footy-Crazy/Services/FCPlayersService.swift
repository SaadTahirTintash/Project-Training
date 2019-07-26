//
//  FCPlayersService.swift
//  Footy-Crazy
//
//  Created by Tintash on 19/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

protocol FCPlayersService: FCNetworkEngine {
    
    typealias successType   = (([FCPlayersModel])->Void)?
    typealias failureType   = ((String)->Void)?
}

extension FCPlayersService {
    
    /// Fetch data from network engine protocol using the required parameters
    ///
    /// - Parameters:
    ///   - id: key to start fetching from
    ///   - limit: window to fetch
    ///   - success: completion handler for success
    ///   - failure: completion handler for failure
    func getPlayerData(startingKey      id      : String,
                       pageSize         limit   : Int,
                       success                  : successType,
                       failure                  : failureType) {
        
        fetchData(pathString: FCConstants.PLAYERS_CONSTANTS.PATH_STRING, startingKey: id, pageSize: limit, success: success, failure: failure)
    }
    
}
