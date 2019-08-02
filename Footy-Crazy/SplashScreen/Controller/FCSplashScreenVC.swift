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
    
    //MARK:- Class Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchInitialData()
    }
}

//MARK:- Extension
extension FCSplashScreenVC: FCNewsFeedService {
    
    //MARK:- Methods
    /// Fetches news feed data, saves data in FCDataManager and sets the root view controller of main window to news feed storyboard initial view controller
    func fetchInitialData() {
        
        FCConstants.TAB_CONSTANTS = .newsFeed
        let NEWSFEED_CONSTANTS = FCConstants.TAB_CONSTANTS.getTabConstants()
        
        getNewsFeedData(startingKey: NEWSFEED_CONSTANTS.STARTING_KEY,
                        pageSize: NEWSFEED_CONSTANTS.INITIAL_PAGE_SIZE,
                        success: { (array) in
                            FCDataManager.shared.addNewsFeedData(item: array)
                            let storyboardID = UIStoryboard(name: NEWSFEED_CONSTANTS.STORYBOARD_ID, bundle: nil)
                            UIApplication.shared.delegate?.window??.rootViewController = storyboardID.instantiateInitialViewController()
        }) {(errorMsg) in
            print(errorMsg)
        }
    }
}

