//
//  tweetTableViewCell.swift
//  tweet_showing_app
//
//  Created by Nguyen Tam Anh Bui on 11/22/17.
//  Copyright © 2017 Nguyen Tam Anh Bui. All rights reserved.
//

import UIKit

class tweetTableViewCell: UITableViewCell {

    // MARK: Properties

    @IBOutlet weak var tweetUser: UILabel!
    @IBOutlet weak var tweetText: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
