//
//  FCNetworkEngine.swift
//  Footy-Crazy
//
//  Created by Tintash on 28/06/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//


import FirebaseDatabase
import Alamofire

//MARK:- Definition
protocol FCNetworkEngine {
    
    typealias success<MODEL_TYPE>   = (([MODEL_TYPE])->Void)?
    typealias failure               = ((String)->Void)?
    
}

//MARK:- Extension
extension FCNetworkEngine {
    
    //MARK:- Computed Properties
    var ref: DatabaseReference {
        return Database.database().reference()
    }
    
    var rootQuery: DatabaseReference {
        return ref.child(FCConstants.FIREBASE_ROOT_NODE)
    }
    
    //MARK:- Methods
    /// Fetch Data from firebase server and observe for return. On return, parse the data and removes the observer. On success, parse data to model one by one using decodables. On failure, prints the required error message
    ///
    /// - Parameters:
    ///   - pathString: Name of the child node to fetch data of
    ///   - id: key from where to start fetching from
    ///   - limit: window of data to fetch
    ///   - success: completion handler for success
    ///   - failure: completion handler for failure
    func fetchData<MODEL_TYPE : Decodable>(pathString           : String,
                                           startingKey  id      : String,
                                           pageSize     limit   : Int,
                                           success              : success<MODEL_TYPE>,
                                           failure              : failure){
        
        rootQuery.child(pathString).queryOrderedByKey().queryStarting(atValue: id).queryLimited(toFirst: UInt(limit)).observeSingleEvent(of: .value) { (snapshot) in
            
            if snapshot.value != nil && snapshot.childrenCount > 0 {
                var modelArray : [MODEL_TYPE]?  = []
                let enumerator                  = snapshot.children
                while let snap = enumerator.nextObject() as? DataSnapshot {
                    do{
                        if let value = snap.value as? [String: Any] {
                            let jsonData    = try JSONSerialization.data(withJSONObject: value, options: [])
                            let decoder     = JSONDecoder()
                            let model       = try decoder.decode(MODEL_TYPE.self, from: jsonData)
                            modelArray?.append(model)
                        }
                    }catch {
                        print(FCConstants.ERRORS.decodingError+" \(error.localizedDescription)")
                    }
                }
                if let modelArray = modelArray {
                    success?(modelArray)
                }else {
                    failure?(FCConstants.ERRORS.arrayNil)
                }
            } else {
                failure?(FCConstants.ERRORS.snapshotNil)
            }
        }
    }
    
    /// Fetch data from an api using Alamofire and get a response JSON. On success, parses the whole array into model using decodables and calls success completion handler. On failure response, prints the error message
    ///
    /// - Parameters:
    ///   - pathString: api link
    ///   - query: query to fetch specific data
    ///   - success: completion handler for success
    ///   - failure: completion handler for failure
    func fetchAPI<MODEL_TYPE: Decodable>(pathString     : String,
                                         query          : String,
                                         success        : success<MODEL_TYPE>,
                                         failure        : failure) {
        
        Alamofire.AF.request(pathString+query).responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                var modelArray: [MODEL_TYPE]? = []
                guard let dataArray = value as? [[String:Any]] else{
                    return
                }
                do{
                    let jsonData    = try JSONSerialization.data(withJSONObject: dataArray)
                    let decoder     = JSONDecoder()
                    let data        = try decoder.decode([MODEL_TYPE].self, from: jsonData)
                    modelArray?.append(contentsOf: data)
                }catch{
                    print(error.localizedDescription)
                }
                if let modelArray = modelArray {
                    success?(modelArray)
                }else {
                    failure?(FCConstants.ERRORS.arrayNil)
                }
            case .failure(let error):
                failure?(error.localizedDescription)
            }
        }
    }
    
    /// Removing all observers if any
    func removeAllObservers(){
        ref.removeAllObservers()
    }
}
