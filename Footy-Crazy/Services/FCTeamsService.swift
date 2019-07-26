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
    
    func getTeamData(startingKey    id      : String,
                     pageSize       limit   : Int,
                     success                : successType,
                     failure                : failureType) {
        
        fetchData(pathString: FCConstants.TEAMS_CONSTANTS.PATH_STRING, startingKey: id, pageSize: limit, success: success, failure: failure)
    }
}
