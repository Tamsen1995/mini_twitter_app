//
//  ViewController.swift
//  tweet_showing_app
//
//  Created by Nguyen Tam Anh Bui on 11/14/17.
//  Copyright © 2017 Nguyen Tam Anh Bui. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, APITwitterDelegate {
    
    
    // Testing Array
    var list = ["I" , "am", "testing", "this", "tableview", "Bruh"]
    
    var token : String?
    var tweetsArray : [Tweet]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        makeRequest(contains: "ecole 42")
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func Tweet(tweet: [Tweet]) {
        print(tweet)
    }
    
    func ErrorCase(error: NSError) {
        print(error)
    }
    
    // The number of cells we need, in this case it's the amount of tweets we receive back
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count // testing
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    

    
    // This function gets the bearer token, and then fires off the search request
    func makeRequest(contains: String) {
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
                            self.token = token as String // might be redundant to cast
                            
                            // Once we have the token, nil check the token and then fire a search to the API
                            if let token = self.token {
                                let controller = APIController(delegate: self, token: token)
                                // sets the tweetsArray in the controller to the desired value
                                controller.SearchRequest(contains) {
                                    tweetsArray in
                                    
                                    
                                    // in here call another completinhandler in order
                                    // to return to the ViewDidLoad Function
                                    
                                    //////////////////////////////////////////////////
                                    for things in tweetsArray {
                                        print(things)
                                    }
                                    //////////////////////////////////////////////////

                                }
                                
                                // which we then set to the ViewControllers tweetsArray for further proceeding
                                
                                
                            }
                        }
                    }
                } catch {
                    print(error)
                }
            }
            }.resume()
    }
    
}

