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
    let token : String
    
    init (delegate: APITwitterDelegate?, token: String) {
        self.delegate = delegate
        self.token = token
    }
    
    // MARK: the intended search request totwards twitter
    
    func request(contains: String) {
        
        
        // A Dictionary of parameters
        let parameters = ["username": "@tamsen910", "tweet": "Hello World !"]
        guard let url = URL(string: "https://api.twitter.com/1.1/search/tweets.json") else {
            print("ERROR: url was invalid")
            return
        }
        var request = URLRequest(url: url)
        
        
        request.httpMethod = "GET"
        // adds a value to the http header
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            return }
        request.httpBody = httpBody
        
        // Making another session but this time we're passing the request into it
        // And not the url
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            // printing the response
            if let response = response {
                print(response)
            }
            // printing the data
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
            }.resume()
    }
    
    // MARK: The request towards twitter in order to get an OAuth2.0 token
    
    func getToken() {
        // Make POST request to the oauth2 endpoint to get the token
        
        
        
        //authorization
        let CONSUMER_KEY = "NeH3OHvCf3bpVSdV2flF8VNOp"
        let CONSUMER_SECRET = "YWsC8y6S7ocAq8HIx21ndKppdFPW6fq6s5ubw2SlEy4lztC4QX"
        let BEARER = ((("\(CONSUMER_KEY):\(CONSUMER_SECRET)")).base64Encoded())!
        
        // set content type to be application/x-www-form-urlencoded;charset=UTF-8
        
        /*
         // Don't know what this means
         
         Accept-Encoding: gzip
         grant_type=client_credentials
         */
        
        // set the url to the oauth 2 https://api.twitter.com/oauth2/token
        guard let url = URL(string: "https://api.twitter.com/oauth2/token") else {
            print("ERROR: The token url was invalid")
            return
        }
        var request = URLRequest(url: url)
        
        // set the http method to POST, since the token we're looking for can be found in the response
        request.httpMethod = "POST"
        // set content type to be application/x-www-form-urlencoded;charset=UTF-8
        request.setValue("Basic \(BEARER)", forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
        
        print(BEARER)
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }          // printing the data
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
}


