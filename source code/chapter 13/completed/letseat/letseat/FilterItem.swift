//
//  FilterItem.swift
//  LetsEat
//
//  Created by Craig Clayton on 11/23/16.
//  Copyright © 2016 Craig Clayton. All rights reserved.
//

import Foundation

struct FilterItem {
    var filter:String?
    var name:String?
}

extension FilterItem {
    init(dict:[String:AnyObject]) {
        name  = dict["name"] as? String
        filter = dict["filter"] as? String
    }
}
