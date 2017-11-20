//
//  ViewController.swift
//  tweet_showing_app
//
//  Created by Nguyen Tam Anh Bui on 11/14/17.
//  Copyright © 2017 Nguyen Tam Anh Bui. All rights reserved.
//

import UIKit

class ViewController: UIViewController, APITwitterDelegate {

    // TODO figure out how to make this work

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let controller = APIController(delegate: self, token: "NeH3OHvCf3bpVSdV2flF8VNOp")
        controller.getToken()
        
        
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

}

