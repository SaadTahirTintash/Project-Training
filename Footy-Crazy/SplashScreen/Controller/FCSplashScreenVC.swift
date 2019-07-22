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

class FCSplashScreenVC: UIViewController, FCNewsFeedService {    
    // do not mate storyboard id a property
    override func viewDidLoad() {
        super.viewDidLoad()
        getNewsFeedData(startingKey: FCConstants.NEWS_FEED_CONSTANTS.STARTING_KEY, pageSize: FCConstants.NEWS_FEED_CONSTANTS.INITIAL_PAGE_SIZE){(success, newsFeedModelArray) in
            if success{
                if let newsFeedModelArray = newsFeedModelArray{
                    FCDataManager.shared.newsFeedData = newsFeedModelArray
                }
                let storyboardID = UIStoryboard(name: "FCNewsFeed", bundle: nil)
                UIApplication.shared.delegate?.window??.rootViewController = storyboardID.instantiateInitialViewController()
            } else{
                print("Problem while loading data from Firebase")
            }
        }
    }
}

