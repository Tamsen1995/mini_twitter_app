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
        guard let url = URL(string: "https://api.twitter.com/1.1/search/tweets.json") else {
            print("ERROR: url was invalid")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if let token = self.token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: contains, options: []) else {
            print("Couldn't make httpBody")
            return
        }
        request.httpBody = httpBody
        
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
    
    func getToken() {
        // Make POST request to the oauth2 endpoint to get the token
        
        //authorization
        let CONSUMER_KEY = "NeH3OHvCf3bpVSdV2flF8VNOp"
        let CONSUMER_SECRET = "YWsC8y6S7ocAq8HIx21ndKppdFPW6fq6s5ubw2SlEy4lztC4QX"
        let BEARER = ((("\(CONSUMER_KEY):\(CONSUMER_SECRET)")).base64Encoded())!
        
        guard let url = URL(string: "https://api.twitter.com/oauth2/token") else {
            print("ERROR: The token url was invalid")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic \(BEARER)", forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print("Response:\n\n \(response)\n\n\n")
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    // extract the bearer token from here and set it to self.token
                    print("The json received is the following:\n \(json)\n\n\n")
                    if let dictionary = json as? [String: String] {
                        if let token = dictionary["access_token"] {
                            print("The bearer token received is: \(token)\n\n")
                            self.token = token
                        }
                    }
                } catch {
                    print(error)
                }
            }
            }.resume()
    }
    
}


