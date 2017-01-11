//
//  MapDataManager.swift
//  LetsEat
//
//  Created by Craig Clayton on 11/15/16.
//  Copyright © 2016 Craig Clayton. All rights reserved.
//

import Foundation
import MapKit
import LetsEatDataKit

class MapDataManager:DataManager {
    
    fileprivate var items:[RestaurantAnnotation] = []

    var annotations:[RestaurantAnnotation] {
        return items
    }

    func fetch(with completion: (_ annotations:[RestaurantAnnotation]) -> ()) {
        for data in RestaurantAPIManager.loadJSON(file: "Chicago") {
            items.append(RestaurantAnnotation(dict: data))
        }
        
        completion(items)
    }
    
    func currentRegion(latDelta:CLLocationDegrees, longDelta:CLLocationDegrees) -> MKCoordinateRegion {
        guard let item = items.first else { return MKCoordinateRegion() }
        let span = MKCoordinateSpanMake(latDelta, longDelta)
        
        return MKCoordinateRegion(center: item.coordinate, span: span)
    }
}















