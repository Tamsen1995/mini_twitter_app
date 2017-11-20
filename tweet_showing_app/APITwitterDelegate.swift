//
//  APITwitterDelegate.swift
//  tweet_showing_app
//
//  Created by Nguyen Tam Anh Bui on 11/15/17.
//  Copyright © 2017 Nguyen Tam Anh Bui. All rights reserved.
//

import Foundation

protocol APITwitterDelegate: class {
    // Function to process incoming tweets
    func Tweet(tweet: [Tweet])
    
    // Function which is called in the case of an error
    func ErrorCase(error: NSError)
    
}
