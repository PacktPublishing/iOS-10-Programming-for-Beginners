//
//  ReviewCell.swift
//  LetsEat
//
//  Created by Craig Clayton on 11/20/16.
//  Copyright © 2016 Craig Clayton. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {
    
    @IBOutlet var imgReview: UIImageView!
    @IBOutlet var imgRating: UIImageView!
    @IBOutlet var lblUser: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblReview: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
