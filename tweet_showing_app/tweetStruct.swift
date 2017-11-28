//
//  tweetStruct.swift
//  tweet_showing_app
//
//  Created by Nguyen Tam Anh Bui on 11/14/17.
//  Copyright © 2017 Nguyen Tam Anh Bui. All rights reserved.
//

import Foundation

// A struct which will contain the individual tweets
struct Tweet: CustomStringConvertible {
    
    let name : String
    let text : String
    let date : String

    var description: String {
        return "Name: \(name) Tweet: \(text)"//" Date: \(date)"
    }
    
}
