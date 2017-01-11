//
//  RestaurantItem.swift
//  LetsEat
//
//  Created by Craig Clayton on 11/15/16.
//  Copyright © 2016 Craig Clayton. All rights reserved.
//

import Foundation

struct RestaurantItem {
    var name:String?
    var city:String?
    var address:String?
    var price:Int?
    var state:String?
    var longitude:Double?
    var latitude:Double?
    var cuisines:[String] = []
    var image:String?
    var restaurantID:Int?
    
    var cuisine: String? {
        if cuisines.isEmpty { return "" }
        else if cuisines.count == 1 { return cuisines.first }
        else { return cuisines.joined(separator: ", ") }
    }
}

extension RestaurantItem {
    public init(dict:[String:AnyObject]) {
        name  = dict["name"] as? String
        city = dict["city"] as? String
        address  = dict["address"] as? String
        price = dict["price"] as? Int
        state = dict["state"] as? String
        longitude = dict["lng"] as? Double
        latitude = dict["lat"] as? Double
        restaurantID = dict["id"] as? Int
        
        if let cuisines = dict["cuisines"] as? [AnyObject] {
            for data in cuisines {
                if let cuisine = data["cuisine"] as? String {
                    self.cuisines.append(cuisine)
                }
            }
        }
        image = dict["image"] as? String
    }
}
