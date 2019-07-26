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
    
    static let NEWS_FEED_CONSTANTS          :FCNewsFeedConstants        = FCNewsFeedConstants()
    static let GALLERY_CONSTANTS            :FCGalleryConstants         = FCGalleryConstants()
    static let PLAYERS_CONSTANTS            :FCPlayersConstants         = FCPlayersConstants()
    static let TEAMS_CONSTANTS              :FCTeamsConstants           = FCTeamsConstants()
    static let CITIES_LOCATION_CONSTANTS    :FCCitiesLocationConstants  = FCCitiesLocationConstants()
    static let NIBS                         :FCNibs                     = FCNibs()
    static let CELL_IDENTIFIERS             :FCCellIdentifiers          = FCCellIdentifiers()
    static let SEGUES                       :FCSegueIdentifiers         = FCSegueIdentifiers()
    static let ERRORS                       :FCErrors                   = FCErrors()
    
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

extension FCConstants {
    
    struct FCNewsFeedConstants {
        let STORYBOARD_ID       :String     = "FCNewsFeed"
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
        let newsLinkDetailVC        :String     = "FCNewsLinkDetailVC"
        let videoDetailVC           :String     = "FCVideoDetailVC"
        let factDetailVC            :String     = "FCFactDetailVC"
        let galleryImageDetailVC    :String     = "GalleryImageDetailVCSegue"
        let teamsDetailVC           :String     = "FCTeamsDetailVCSegue"
        let playersDetailVC         :String     = "FCPlayersDetailVCSegue"
    }
}
