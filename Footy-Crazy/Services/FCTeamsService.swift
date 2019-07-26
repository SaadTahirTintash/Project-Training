//
//  FCTeamsService.swift
//  Footy-Crazy
//
//  Created by Tintash on 19/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

protocol FCTeamsService: FCNetworkEngine {

    typealias successType   = (([FCTeamsModel])->Void)?
    typealias failureType   = ((String)->Void)?
}

extension FCTeamsService{
    
    /// Fetch data from network engine protocol using the required parameters
    ///
    /// - Parameters:
    ///   - id: key to start fetching from
    ///   - limit: window to fetch
    ///   - success: completion handler for success
    ///   - failure: completion handler for failure
    func getTeamData(startingKey    id      : String,
                     pageSize       limit   : Int,
                     success                : successType,
                     failure                : failureType) {
        
        fetchData(pathString: FCConstants.TEAMS_CONSTANTS.PATH_STRING, startingKey: id, pageSize: limit, success: success, failure: failure)
    }
}
