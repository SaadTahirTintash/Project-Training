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
    }
    
    func readDatabase(){
        dbRef.child("test").observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let firstName = value?["firstName"] as? String ?? ""
            let lastName = value?["lastName"] as? String ?? ""
            let person = Person(firstName: firstName, lastName: lastName)
            print(person)
        }
    }


}

