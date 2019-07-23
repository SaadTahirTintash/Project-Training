//
//  FCNetworkEngine.swift
//  Footy-Crazy
//
//  Created by Tintash on 28/06/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//


import FirebaseDatabase
import Alamofire

protocol FCNetworkEngine{
    typealias success<MODEL_TYPE>   = (([MODEL_TYPE])->Void)?
    typealias failure               = ((String)->Void)?
}
extension FCNetworkEngine{
    var ref: DatabaseReference{
        return Database.database().reference()
    }
    
    var rootQuery: DatabaseReference{
        return ref.child("footy_crazy_data")
    }
    
    func fetchData<MODEL_TYPE : Decodable>(pathString           : String,
                                           startingKey  id      : String,
                                           pageSize     limit   : Int,
                                           success              : success<MODEL_TYPE>,
                                           failure              : failure){
        
        rootQuery.child(pathString).queryOrderedByKey().queryStarting(atValue: id).queryLimited(toFirst: UInt(limit)).observeSingleEvent(of: .value) {(snapshot) in
            if snapshot.value != nil && snapshot.childrenCount > 0{
                var modelArray  : [MODEL_TYPE]?   = [MODEL_TYPE]()
                let enumerator = snapshot.children
                while let snap = enumerator.nextObject() as? DataSnapshot{
                    do{
                        if let value = snap.value as? [String: Any]{
                            let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                            let decoder = JSONDecoder()
                            let model = try decoder.decode(MODEL_TYPE.self, from: jsonData)
                            modelArray?.append(model)
                        }
                    }catch{
                        print("Whoops! An error occured while decoding NewsFeed: \(error.localizedDescription)")
                    }
                }
                if let modelArray = modelArray{
                    success?(modelArray)
                }else{
                    failure?("Model array is nil")
                }
            } else{
                failure?("No Data Found")
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
