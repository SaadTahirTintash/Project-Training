//
//  FCConstants.swift
//  Footy-Crazy
//
//  Created by Tintash on 02/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//
import UIKit

struct FCConstants {
    
    static let FIREBASE_ROOT_NODE           : String                    = "footy_crazy_data"
    
    static let CITIES_LOCATION_CONSTANTS    : FCCitiesLocationConstants = FCCitiesLocationConstants()
    static let NIBS                         : FCNibs                    = FCNibs()
    static let CELL_IDENTIFIERS             : FCCellIdentifiers         = FCCellIdentifiers()
    static let SEGUES                       : FCSegueIdentifiers        = FCSegueIdentifiers()
    static let ERRORS                       : FCErrors                  = FCErrors()
    static var TAB_CONSTANTS                : FCTabEnum                 = .none
    
    static let DATA_FETCH_THRESHOLD         : Int                       = 2
    
    static let GALLERY_CELL_ROW_COUNT       : Int                       = 2

    
    static let EMPTY_IMAGE                  : UIImage?                  = UIImage(named: "emptyImage")
    static let EMPTY_NEWS_IMAGE_URL         : URL?                      = URL(string: "https:\\google.com")
    static let EMPTY_NEWS_URL               : URL?                      = URL(string:"https:\\google.com")
    static let EMPTY_NEWS_URL_STRING        : String                    = "https:\\google.com"
    static let EMPTY_NEWS_DESCRIPTION       : String                    = "News Description"
    static let EMPTY_NEWS_TITLE             : String                    = "News Title"
    
    static let ABOUT_US                     : String                    = """
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

extension FCConstants {
        
    enum FCTabEnum {
        case none
        case newsFeed
        case gallery
        case players
        case teams
        
        func getTabConstants() -> FCTabsConstants{
            switch self {
            case .none:                
                return FCTabsConstants(STORYBOARD_ID: "", PATH_STRING: "", STARTING_KEY: "", INITIAL_PAGE_SIZE: 0, PAGE_SIZE: 0)
            case .newsFeed:
                return FCTabsConstants(STORYBOARD_ID: "FCNewsFeed", PATH_STRING: "news_feed", STARTING_KEY: "1", INITIAL_PAGE_SIZE: 5, PAGE_SIZE: 5)
            case .gallery:
                return FCTabsConstants(STORYBOARD_ID: "FCGallery", PATH_STRING: "gallery", STARTING_KEY: "1", INITIAL_PAGE_SIZE: 10, PAGE_SIZE: 5)
            case .players:
                return FCTabsConstants(STORYBOARD_ID: "FCPlayers", PATH_STRING: "players", STARTING_KEY: "1", INITIAL_PAGE_SIZE: 10, PAGE_SIZE: 5)
            case .teams:
                return FCTabsConstants(STORYBOARD_ID: "FCTeams", PATH_STRING: "teams", STARTING_KEY: "1", INITIAL_PAGE_SIZE: 10, PAGE_SIZE: 5)
            }
        }
    }
    
    struct FCTabsConstants {
        let STORYBOARD_ID       :String
        let PATH_STRING         :String
        let STARTING_KEY        :String
        let INITIAL_PAGE_SIZE   :Int
        let PAGE_SIZE           :Int
    }
    
    struct FCCitiesLocationConstants {
        let PATH_STRING         :String     = "https://www.metaweather.com/api/location/search/"
        let QUERY_STRING        :String     = "?query=san"
    }
    
    struct FCNibs {
        let video               :String     = "FCVideoTableViewCell"
        let fact                :String     = "FCFactTableViewCell"
        let newsLink            :String     = "FCNewsLinkTableViewCell"
        let teams               :String     = "FCTeamTableViewCell"
        let players             :String     = "FCPlayerTableViewCell"
        let citiesLocation      :String     = "FCCitiesLocationCell"
    }
    
    struct FCCellIdentifiers {
        let video               :String     = "VideoCell"
        let fact                :String     = "FactCell"
        let newsLink            :String     = "NewsLinkCell"
        let gallery             :String     = "GalleryCell"
        let team                :String     = "TeamCell"
        let player              :String     = "PlayerCell"
        let citiesLocation      :String     = "FCCitiesLocationCell"
        let defaultTableCell    :String     = "DefaultTableCell"
        let defaultGalleryCell  :String     = "DefaultGalleryCell"
    }
    
    struct FCErrors {
        let wrongCell               :String     = "Wrong Cell!"
        let invalidUrl              :String     = "Invalid URL!"
        let decodingError           :String     = "Whoops! An error occured while decoding!"
        let arrayNil                :String     = "Model array is nil"
        let snapshotNil             :String     = "Firebase Snapshot found Nil!"
        let invalidUrlString        :String     = "Incorrect URL string!"
        let invalidUrlData          :String     = "URL Data conversion failure!"
        let imageDownloadingFailed  :String     = "Error while downloading image data!"
        let segueError              :String     = "Can't perform segue for empty cells"
    }
    
    struct FCSegueIdentifiers {
        let newsLinkDetailVC        :String     = "NewsFeedToNewsLinkDetailSegue"
        let videoDetailVC           :String     = "NewsFeedToVideoDetailSegue"
        let factDetailVC            :String     = "NewsFeedToFactDetailSegue"
        let galleryImageDetailVC    :String     = "GalleryToGalleryDetailSegue"
        let teamsDetailVC           :String     = "TeamToTeamDetailSegue"
        let playersDetailVC         :String     = "PlayerToPlayerDetailSegue"
    }
}
