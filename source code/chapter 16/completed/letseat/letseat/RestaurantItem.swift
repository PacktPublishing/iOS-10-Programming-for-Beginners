//
//  RestaurantItem.swift
//  LetsEat
//
//  Created by Craig Clayton on 11/15/16.
//  Copyright © 2016 Craig Clayton. All rights reserved.
//

import Foundation

public struct RestaurantItem {
    public var name:String?
    public var city:String?
    public var address:String?
    public var price:Int?
    public var state:String?
    public var longitude:Double?
    public var latitude:Double?
    public var cuisines:[String] = []
    public var image:String?
    public var restaurantID:Int?
    public var data:[String:AnyObject]?

    
    public var cuisine: String? {
        if cuisines.isEmpty { return "" }
        else if cuisines.count == 1 { return cuisines.first }
        else { return cuisines.joined(separator: ", ") }
    }
    
    public var annotation:RestaurantAnnotation {
        guard let restaurantData = data else { return RestaurantAnnotation(dict:[:]) }
        return RestaurantAnnotation(dict: restaurantData)
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
        data = dict
    }
}
