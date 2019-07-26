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
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        getNewsFeedData(startingKey: FCConstants.NEWS_FEED_CONSTANTS.STARTING_KEY,
                        pageSize: FCConstants.NEWS_FEED_CONSTANTS.INITIAL_PAGE_SIZE,
                        success: { (array) in
            FCDataManager.shared.addNewsFeedData(item: array)
            let storyboardID = UIStoryboard(name: FCConstants.NEWS_FEED_CONSTANTS.STORYBOARD_ID, bundle: nil)
            UIApplication.shared.delegate?.window??.rootViewController = storyboardID.instantiateInitialViewController()
        }) {(errorMsg) in
            print(errorMsg)
        }
    }
}

