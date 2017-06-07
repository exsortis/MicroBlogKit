//
//  Empty.swift
//  MicroBlogKit
//
//  Created by Paul Schifferer on 6/6/17.
//  Copyright © 2017 Pilgrimage Software. All rights reserved.
//

import Foundation


public struct Empty {
    
}


extension Empty : Serializable {
    
    public init?(from json: JSONDictionary) {
        
    }
    
    public func toDictionary() -> JSONDictionary {
        return [:]
    }
    
}
