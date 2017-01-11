//
//  RestaurantAnnotation.swift
//  LetsEat
//
//  Created by Craig Clayton on 11/15/16.
//  Copyright © 2016 Craig Clayton. All rights reserved.
//

import UIKit
import MapKit

public class RestaurantAnnotation: NSObject, MKAnnotation {
    
    public var name: String?
    public var cuisines:[String] = []
    public var latitude: Double?
    public var longitude:Double?
    public var address:String?
    public var postalCode:String?
    public var state:String?
    public var imageURL:String?
    public var data:[String:AnyObject]?
    
    public init(dict:[String:AnyObject]) {
        if let lat = dict["lat"] as? Double { self.latitude = lat }
        if let long = dict["lng"] as? Double { self.longitude = long }
        if let name = dict["name"] as? String { self.name = name }
        if let cuisines = dict["cuisines"] as? [AnyObject] {
            for data in cuisines {
                if let cuisine = data["cuisine"] as? String {
                    self.cuisines.append(cuisine)
                }
            }
        }
        if let address = dict["address"] as? String { self.address = address }
        if let postalCode = dict["postal_code"] as? String { self.postalCode = postalCode }
        if let state = dict["state"] as? String { self.state = state }
        if let image = dict["image_url"] as? String { self.imageURL = image }
        
        data = dict
    }
    
    public var title: String? {
        return name
    }
    
    public var subtitle: String? {
        if cuisines.isEmpty { return "" }
        else if cuisines.count == 1 { return cuisines.first }
        else { return cuisines.joined(separator: ", ") }
    }
    
    public var coordinate: CLLocationCoordinate2D {
        guard let lat = latitude, let long = longitude else { return CLLocationCoordinate2D() }
        return CLLocationCoordinate2D(latitude: lat, longitude: long )
    }
    
    public var restaurantItem:RestaurantItem {
        guard let restaurantData = data else { return RestaurantItem() }
        return RestaurantItem(dict: restaurantData)
    }
}

























