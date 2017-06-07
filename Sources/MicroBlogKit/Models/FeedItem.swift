//
//  FeedItem.swift
//  MicroBlogKit
//
//  Created by Paul Schifferer on 5/6/17.
//  Copyright © 2017 Pilgrimage Software. All rights reserved.
//

import Foundation


private let dateFormatter = ISO8601DateFormatter()

public struct FeedItem {
    public let id : String
    public let author : Author
    public let url : URL
    public let contentHTML : String
    public let datePublished : Date
    public let extensions : [String : Any]
}


extension FeedItem : Serializable {
    
    public init?(from json : JSONDictionary) {
        guard let id = json["id"] as? String,
            let a = json["author"] as? [String : Any],
            let author = Author(from: a),
            let u = json["url"] as? String,
            let url = URL(string: u),
            let contentHTML = json["content_html"] as? String,
            let d = json["date_published"] as? String,
            let datePublished = dateFormatter.date(from: d)
            else { return nil }
        
        self.id = id
        self.author = author
        self.url = url
        self.contentHTML = contentHTML
        self.datePublished = datePublished
        
        if let e = json["_microblog"] as? [String : Any] {
            self.extensions = e
        }
        else {
            self.extensions = [:]
        }
    }
    
    public func toDictionary() -> JSONDictionary {
        var dict : JSONDictionary = [
            "id" : id,
            "author" : author.toDictionary(),
            "url" : url.absoluteString,
            "content_html" : contentHTML,
            "date_published" : dateFormatter.string(from: datePublished),
            ]
        
        if self.extensions.count > 0 {
            dict["_microblog"] = extensions
        }
        
        return dict
    }
    
}
