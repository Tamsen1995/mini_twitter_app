//
//  APIController.swift
//  tweet_showing_app
//
//  Created by Nguyen Tam Anh Bui on 11/14/17.
//  Copyright © 2017 Nguyen Tam Anh Bui. All rights reserved.
//

// API Key: NeH3OHvCf3bpVSdV2flF8VNOp

import Foundation

class APIController {
    
    weak var delegate : APITwitterDelegate?
    var token : String?
    
    init (delegate: APITwitterDelegate?, token: String) {
        self.delegate = delegate
        self.token = token
    }
    

    
    // MARK: the intended search request totwards twitter
    // Makes the search request and then puts in an the array of structs in the sub function "extractTweets"
    func SearchRequest(_ contains: String) {
        
        // make a request using the unique bearer token here
        
        // the array of structs of tweets to be returned
        var tweetsStructArr: [Tweet] = []
        
        let q = contains.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        guard let url = URL(string: "https://api.twitter.com/1.1/search/tweets.json?q=\(q!))&count=2&lang=fr&result_type=recent") else {
            print("ERROR: url was invalid")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if let token = self.token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print("response:\n\n\(response)\n\n")
            }
            if let data = data {
                do {
                    // Converting the json data into a dictionary
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    if let tweetsD : [NSDictionary] = json!["statuses"]! as? [NSDictionary] {
                        tweetsStructArr = self.extractTweets(tweetsD)
                    }
                } catch {
                    print(error)
                }
            }
            }.resume()
    }
    
    private func extractTweets (_ tweetsDictionary: [NSDictionary]) -> [Tweet] {
        
        // The array of tweet structs to be returned
        var ret: [Tweet] = []

        // iterating over the elements in the tweets dictionary
        for tweet in tweetsDictionary {
            // each tweet is a NSDictionary
            // the text key is the key in the Dict we're looking for
            // also the "user" key
            print(tweet["user"])
            if let tweetText = tweet["text"] {
                // tweetText is the extracted text
                print(tweetText)
            }
            // TODO: EXTRACT USERNAME, AND ALL OTHER NECESSARY INFO
            // TODO: CLEAN UP CODE
        }
        return ret
    }
    
    // MARK: The request towards twitter in order to get an OAuth2.0 token
    
    
}


