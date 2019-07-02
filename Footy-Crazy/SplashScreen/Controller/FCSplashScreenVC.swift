//
//  SplashScreenVC.swift
//  Footy-Crazy
//
//  Created by Tintash on 01/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit

class FCSplashScreenVC: UIViewController {

    let storyboardID = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)        
        //wait for data to be loaded
        
        FCDataManager.shared.getNewsFeedOnce(completion: { [weak self] (success) in
            if success{
                if let vc = self?.storyboardID.instantiateViewController(withIdentifier: "NewsFeedVC") as? FCNewsFeedVC{
                    print("Successfully loaded data from Firebase")
                    self?.present(vc, animated: true, completion: nil)
                }
                else{
                    print("Error loading NewsFeedVC")
                }
            }
            else{
                print("Problem while loading data from Firebase")
            }
        })
        
    }
    
    

}
