//
//  FCTeamsService.swift
//  Footy-Crazy
//
//  Created by Tintash on 19/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

protocol FCTeamsService: FCNetworkEngineProtocol {}
extension FCTeamsService{
    func getTeamData(startingKey id: String, pageSize limit: Int, completion: ((_ success: Bool,_ teamModelArray: [FCTeamsModel]?)->Void)?){
        fetchData(pathString: FCConstants.TEAMS_CONSTANTS.PATH_STRING, startingKey: id, pageSize: limit, completion: completion)
    }
}
