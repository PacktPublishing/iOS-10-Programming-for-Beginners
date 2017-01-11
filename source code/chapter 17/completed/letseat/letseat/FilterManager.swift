//
//  FilterManager.swift
//  LetsEat
//
//  Created by Craig Clayton on 11/23/16.
//  Copyright © 2016 Craig Clayton. All rights reserved.
//

import Foundation

class FilterManager: DataManager {
    
    private var items:[FilterItem] = []
    
    func fetch() {
        for data in load(file: "FilterData") {
            items.append(FilterItem(dict: data))
        }
    }
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    func filterItemAtIndexPath(index:IndexPath) -> FilterItem {
        return items[index.item]
    }
}
