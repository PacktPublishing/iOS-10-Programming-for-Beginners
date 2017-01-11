//
//  RestaurantDataManager.swift
//  LetsEat
//
//  Created by Craig Clayton on 11/18/16.
//  Copyright © 2016 Craig Clayton. All rights reserved.
//

import Foundation

class RestaurantDataManager {
    
    private var items:[RestaurantItem] = []

    public func fetch(by location:String, withFilter:String="All",  completionHandler:() -> Swift.Void) {
        var restaurants:[RestaurantItem] = []
        
        for restaurant in RestaurantAPIManager.loadJSON(file: location) {
            restaurants.append(RestaurantItem(dict: restaurant))
        }
        
        if withFilter != "All" {
            items = restaurants.filter({ $0.cuisines.contains(withFilter) })
        }
        else { items = restaurants }
        
        completionHandler()
    }
    
    public func numberOfItems() -> Int {
        return items.count
    }
    
    public func restaurantItem(at index:IndexPath) -> RestaurantItem {
        return items[index.item]
    }
}







