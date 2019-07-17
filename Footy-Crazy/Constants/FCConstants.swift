//
//  FCConstants.swift
//  Footy-Crazy
//
//  Created by Tintash on 02/07/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//
import UIKit

class Constants{
    static let NEWS_FEED_PATH_STRING        :String     = "news_feed"
    static let GALLERY_PATH_STRING          :String     = "gallery"
    static let TEAMS_PATH_STRING            :String     = "teams"
    static let PLAYERS_PATH_STRING          :String     = "players"
    
    static let NEWS_FEED_STARTING_KEY       :String     = "1"
    static let GALLERY_STARTING_KEY         :String     = "1"
    static let TEAMS_STARTING_KEY           :String     = "1"
    static let PLAYERS_STARTING_KEY         :String     = "1"

    static let NEWS_FEED_INITIAL_PAGE_SIZE  :Int        = 5
    static let GALLERY_INITIAL_PAGE_SIZE    :Int        = 10
    static let TEAMS_INITIAL_PAGE_SIZE      :Int        = 10
    static let PLAYERS_INITIAL_PAGE_SIZE    :Int        = 10
    
    static let NEWS_FEED_PAGE_SIZE          :Int        = 5
    static let GALLERY_PAGE_SIZE            :Int        = 5
    static let TEAMS_PAGE_SIZE              :Int        = 5
    static let PLAYERS_PAGE_SIZE            :Int        = 5
    
    static let EMPTY_IMAGE                  :UIImage?   = UIImage(named: "emptyImage")
    static let EMPTY_NEWS_IMAGE_URL         :URL?       = URL(string: "https:\\google.com")
    static let EMPTY_NEWS_URL               :URL?       = URL(string:"https:\\google.com")
    static let EMPTY_NEWS_URL_STRING        :String     = "https:\\google.com"
    static let EMPTY_NEWS_DESCRIPTION       :String     = "News Description"
    static let EMPTY_NEWS_TITLE             :String     = "News Title"
    
    static let ABOUT_US                     :String     = "This text is about us"
    
    static let GALLERY_CELL_ROW_COUNT       :Int        = 2
}
