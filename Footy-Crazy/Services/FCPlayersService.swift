//
//  FCPlayersService.swift
//  Footy-Crazy
//
//  Created by Tintash on 19/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

protocol FCPlayersService: FCNetworkEngineProtocol {}
extension FCPlayersService{
    func getPlayerData(startingKey id: String, pageSize limit: Int, completion: ((_ success: Bool, _ playerModelArray: [FCPlayersModel]?)->Void)?){
        fetchData(pathString: FCConstants.PLAYERS_CONSTANTS.PATH_STRING, startingKey: id, pageSize: limit, completion: completion)
    }
}
