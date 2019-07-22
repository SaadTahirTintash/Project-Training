//
//  FCNetworkEngine.swift
//  Footy-Crazy
//
//  Created by Tintash on 28/06/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//


import FirebaseDatabase
import Alamofire
import SwiftyJSON // remove it

protocol FCNetworkEngineProtocol{ // remname
    
}

extension FCNetworkEngineProtocol{
    var ref: DatabaseReference{
        return Database.database().reference()
    }
    var rootQuery: DatabaseReference{
        return ref.child("footy_crazy_data")
    }
    
    func fetchData<MODEL_TYPE>(pathString: String, startingKey id: String, pageSize limit: Int, completion: ((Bool,[MODEL_TYPE]?)->Void)?) where MODEL_TYPE : Decodable {
        rootQuery.child(pathString).queryOrderedByKey().queryStarting(atValue: id).queryLimited(toFirst: UInt(limit)).observeSingleEvent(of: .value) {(snapshot) in
            if snapshot.value != nil && snapshot.childrenCount > 0{
                var modelArray = [MODEL_TYPE]()
                let enumerator = snapshot.children
                while let snap = enumerator.nextObject() as? DataSnapshot{
                    do{
                        if let value = snap.value as? [String: Any]{
                            let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                            let decoder = JSONDecoder()
                            let model = try decoder.decode(MODEL_TYPE.self, from: jsonData)
                            modelArray.append(model)
                        }
                    }catch{
                        print("Whoops! An error occured while decoding NewsFeed: \(error.localizedDescription)")
                    }
                }
                completion?(true,modelArray)
            } else{
                completion?(false,nil)
            }
        }
    }
    
    func fetchAPI<MODEL_TYPE>(pathString: String, query: String, completion: ((_ success: Bool,_ modelArray: [MODEL_TYPE]?)->Void)?) where MODEL_TYPE: Decodable{
        Alamofire.AF.request(pathString+query).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                var modelArray: [MODEL_TYPE] = []
                guard let dataArray = value as? [[String:Any]] else{
                    return
                }
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: dataArray)
                    let decoder = JSONDecoder()
                    let data = try decoder.decode([MODEL_TYPE].self, from: jsonData)
                    modelArray.append(contentsOf: data)
                }catch{
                    print(error.localizedDescription)
                }
                completion?(true,modelArray)
            case .failure(let error):
                print(error.localizedDescription)
                completion?(false,nil)
            }
        }
    }
    
    func removeAllObservers(){
        ref.removeAllObservers()
    }
}
