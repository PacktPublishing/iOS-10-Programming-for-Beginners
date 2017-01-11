//
//  LocationDataManager.swift
//  LetsEat
//
//  Created by Craig Clayton on 11/10/16.
//  Copyright © 2016 Craig Clayton. All rights reserved.
//

import Foundation

class LocationDataManager {
    private var arrLocations:[String] = []
    
    func fetch() {
        for location in loadData() {
            arrLocations.append(location)
        }
    }
    
    func numberOfItems() -> Int {
        return arrLocations.count
    }
    
    func locationItem(at index:IndexPath) -> String {
        return arrLocations[index.item]
    }
    
    private func loadData() -> [String] {
        guard let path = Bundle.main.path(forResource: "Locations", ofType: "plist"),
            let items = NSArray(contentsOfFile: path) else { return [] }
        
        return items as! [String]
    }
}
