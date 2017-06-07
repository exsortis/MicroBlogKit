//
//  Author.swift
//  MicroBlogKit
//
//  Created by Paul Schifferer on 5/6/17.
//  Copyright © 2017 Pilgrimage Software. All rights reserved.
//

import Foundation


public struct Author {
    public let name : String
    public let url : URL
    public let avatar : URL
    public let extensions : [String : Any]
}


extension Author : Serializable {

    public init?(from json : JSONDictionary) {
        guard let name = json["name"] as? String,
            let u = json["url"] as? String,
            let url = URL(string: u),
            let a = json["avatar"] as? String,
            let avatar = URL(string: a)
            else { return nil }

        self.name = name
        self.url = url
        self.avatar = avatar

        if let e = json["_microblog"] as? [String : Any] {
            self.extensions = e
        }
        else {
            self.extensions = [:]
        }
    }

    public func toDictionary() -> JSONDictionary {
        var dict : JSONDictionary = [
            "name" : name,
            "url" : url.absoluteString,
            "avatar" : avatar.absoluteString,
        ]

        if self.extensions.count > 0 {
            dict["_microblog"] = extensions
        }

        return dict
    }

}
