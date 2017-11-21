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
    
    func SearchRequest(contains: String) {
        
        // make a request using the unique bearer token here
        
        let q = contains.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        guard let url = URL(string: "https://api.twitter.com/1.1/search/tweets.json?q=\(q!))&count=100&lang=fr&result_type=recent") else {
            print("ERROR: url was invalid")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if let token = self.token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
     //   request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        

        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print("response:\n\n\(response)\n\n")
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print("json:\n\n\(json)\n\n")
                } catch {
                    print(error)
                }
                
            }
            }.resume()
    }
    
    // MARK: The request towards twitter in order to get an OAuth2.0 token

    
}


