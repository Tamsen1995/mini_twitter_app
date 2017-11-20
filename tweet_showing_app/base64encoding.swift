//
//  base64encoding.swift
//  tweet_showing_app
//
//  Created by Nguyen Tam Anh Bui on 11/19/17.
//  Copyright © 2017 Nguyen Tam Anh Bui. All rights reserved.
//

import Foundation

extension String {
    //: Base 64 encoding a string
    // turning the string into data and then using data to encode it into a base64 string
    func base64Encoded() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    //: ### Base 64 decoding a string
    func base64Decoded() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    
}
