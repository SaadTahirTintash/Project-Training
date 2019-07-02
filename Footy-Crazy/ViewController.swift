//
//  ViewController.swift
//  Footy-Crazy
//
//  Created by Tintash on 27/06/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit
import FirebaseDatabase

struct Person {
    let firstName: String
    let lastName: String
}

class ViewController: UIViewController {

    var dbRef : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dbRef = Database.database().reference()
        readDatabase()
        
        print("Checking the git hub repo is configured")
    }
    
    func readDatabase(){
//        dbRef.child("news_feed").observeSingleEvent(of: .value) { (snapshot) in
//            let enumerator = snapshot.children
//            while let value = enumerator.nextObject() as? DataSnapshot{
//                if let object = value.value as? [String: Any]{
//                    print("Object type: \(object["type"] ?? "")")
//                }
//
//            }
//        }
        dbRef.child("news_feed").observe(.value) { (snapshot) in
            let enumerator = snapshot.children
            while let value = enumerator.nextObject() as? DataSnapshot{
                if let object = value.value as? [String: Any]{
                    print("Object type: \(object["type"] ?? "")")
                }
                
            }
        }
    }


}

