//
//  SplashScreenVC.swift
//  Footy-Crazy
//
//  Created by Tintash on 01/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

/*
 - This VC asks for a small set of data from the dataManager and waits for it
 - On completion, it creates and opens the next VC
 - THE END
 */

import UIKit

class FCSplashScreenVC: UIViewController {

    let storyboardID = UIStoryboard(name: "Main", bundle: nil)
    let startingKey = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)        
        //wait for data to be loaded        
        FCDataManager.shared.getNewsFeed(key: startingKey, pageSize: Constants.NEWS_FEED_PAGE_SIZE) { [weak self](success, _) in
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
        }
    }
    
    

}
