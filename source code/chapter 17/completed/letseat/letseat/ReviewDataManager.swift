//
//  ReviewDataManager.swift
//  LetsEat
//
//  Created by Craig Clayton on 11/23/16.
//  Copyright © 2016 Craig Clayton. All rights reserved.
//

import Foundation

class ReviewDataManager: NSObject {
    
    private var items:[ReviewItem] = []
    let manager = CoreDataManager()
    
    func fetchReview(by id:Int) {
        
        if items.count > 0 { items.removeAll() }
        
        for data in manager.fetchReviews(by: id) {
            items.append(data)
        }
    }
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    func reviewItem(at index:IndexPath) -> ReviewItem {
        return items[index.item]
    }
    
    func getLatestReview() -> ReviewItem {
        guard let item = items.first else {
            return ReviewItem()
        }
        
        return item
    }

}
