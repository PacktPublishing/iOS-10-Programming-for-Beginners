//
//  ExploreDataManager.swift
//  LetsEat
//
//  Created by Craig Clayton on 11/1/16.
//  Copyright © 2016 Craig Clayton. All rights reserved.
//

import Foundation

class ExploreDataManager:DataManager {
    
    fileprivate var items:[ExploreItem] = []
    
    func fetch() {
        for data in load(file:"ExploreData") {
            items.append(ExploreItem(dict: data))
        }
    }
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    func explore(at index:IndexPath) -> ExploreItem {
        return items[index.item]
    }
}




























