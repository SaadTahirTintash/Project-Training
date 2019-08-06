//
//  FCConstants.swift
//  Footy-Crazy
//
//  Created by Tintash on 02/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//
import UIKit

struct FCConstants{
    static let NEWS_FEED_CONSTANTS          :FCNewsFeedConstants        = FCNewsFeedConstants()
    static let GALLERY_CONSTANTS            :FCGalleryConstants         = FCGalleryConstants()
    static let PLAYERS_CONSTANTS            :FCPlayersConstants         = FCPlayersConstants()
    static let TEAMS_CONSTANTS              :FCTeamsConstants           = FCTeamsConstants()
    static let CITIES_LOCATION_CONSTANTS    :FCCitiesLocationConstants  = FCCitiesLocationConstants()
    static let DATA_FETCH_THRESHOLD         :Int                        = 2
    static let EMPTY_IMAGE                  :UIImage?                   = UIImage(named: "emptyImage")
    static let EMPTY_NEWS_IMAGE_URL         :URL?                       = URL(string: "https:\\google.com")
    static let EMPTY_NEWS_URL               :URL?                       = URL(string:"https:\\google.com")
    static let EMPTY_NEWS_URL_STRING        :String                     = "https:\\google.com"
    static let EMPTY_NEWS_DESCRIPTION       :String                     = "News Description"
    static let EMPTY_NEWS_TITLE             :String                     = "News Title"
    static let ABOUT_US                     :String                     = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
"""
}

//Code Review
// use enum for these and get properties values based on the enum type
extension FCConstants{
    struct FCNewsFeedConstants {
        let PATH_STRING         :String     = "news_feed"
        let STARTING_KEY        :String     = "1"
        let INITIAL_PAGE_SIZE   :Int        = 5
        let PAGE_SIZE           :Int        = 5
    }
    struct FCGalleryConstants {
        let PATH_STRING         :String     = "gallery"
        let STARTING_KEY        :String     = "1"
        let INITIAL_PAGE_SIZE   :Int        = 10
        let PAGE_SIZE           :Int        = 5
        let CELL_ROW_COUNT      :Int        = 2
    }
    struct FCPlayersConstants {
        let PATH_STRING         :String     = "players"
        let STARTING_KEY        :String     = "1"
        let INITIAL_PAGE_SIZE   :Int        = 10
        let PAGE_SIZE           :Int        = 5
    }
    struct FCTeamsConstants {
        let PATH_STRING         :String     = "teams"
        let STARTING_KEY        :String     = "1"
        let INITIAL_PAGE_SIZE   :Int        = 10
        let PAGE_SIZE           :Int        = 5
    }
    struct FCCitiesLocationConstants {
        let PATH_STRING         :String = "https://www.metaweather.com/api/location/search/"
        let QUERY_STRING        :String = "?query=san"
    }
}
