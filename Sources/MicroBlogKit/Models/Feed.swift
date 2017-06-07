//
//  Feed.swift
//  MicroBlogKit
//
//  Created by Paul Schifferer on 5/6/17.
//  Copyright © 2017 Pilgrimage Software. All rights reserved.
//

import Foundation


public struct Feed {
    public let version : String?
    public let title : String
    public let homePageURL : URL
    public let feedURL : URL
    public let items : [FeedItem]
    public let extensions : [String : Any] 
}


extension Feed : Serializable {

    public init?(from json : JSONDictionary) {
        guard let title = json["title"] as? String,
            let h = json["home_page_url"] as? String,
            let homePageUrl = URL(string: h),
            let f = json["feed_url"] as? String,
            let feedUrl = URL(string: f),
            let items = json["items"] as? [[String : Any]]
            else { return nil }

        self.version = json["version"] as? String 
        self.title = title
        self.homePageURL = homePageUrl
        self.feedURL = feedUrl
        self.items = items.flatMap(FeedItem.init(from:))

        if let e = json["_microblog"] as? [String : Any] {
            self.extensions = e
        }
        else {
            self.extensions = [:]
        }
}

    public func toDictionary() -> JSONDictionary {
        var dict : JSONDictionary = [
            "title" : title,
            "home_page_url" : homePageURL.absoluteString,
            "feed_url" : feedURL.absoluteString,
            "items" : items.flatMap { $0.toDictionary() }
        ]

        if self.extensions.count > 0 {
            dict["_microblog"] = extensions
        }

        return dict
    }

}
