//
//  FCDataManager.swift
//  Footy-Crazy
//
//  Created by Tintash on 01/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//
class FCDataManager{
    
    static let shared = FCDataManager()
    private let networkEngine : NetworkEngine?
    var newsFeedObject: NewsFeedM = NewsFeedM()    
    
    private init(){
        networkEngine = NetworkEngine()
    }
    
    func getNewsFeedOnce(completion: @escaping (_ success: Bool)->()){
        networkEngine?.loadNewsFeedOnce(completion: { [weak self] (success, newsFeedObject) in
            if success{
                self?.newsFeedObject = newsFeedObject!
            }
            completion(success)
        })
    }
    
    //MARK: Add observers
    func getNewsFeed(completion: @escaping(_ success: Bool)->()){
        networkEngine?.loadNewsFeed(completion: { [weak self] (success, newsFeedObject) in
            if success{
                self?.newsFeedObject = newsFeedObject!
            }
            completion(success)
        })
    }
    
    //MARK: Remove observers
    func removeAllObservers(){
        networkEngine?.removeAllObservers()
    }
    
    func removeNewsFeedObserver(){
        networkEngine?.removeNewsFeedObserver()
    }
    
}
