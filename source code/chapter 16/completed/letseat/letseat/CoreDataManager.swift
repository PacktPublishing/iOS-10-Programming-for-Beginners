//
//  CoreDataManager.swift
//  LetsEat
//
//  Created by Craig Clayton on 11/20/16.
//  Copyright © 2016 Craig Clayton. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    let container:NSPersistentContainer
    var selectedID:Int?
    
    override init() {
        container = NSPersistentContainer(name: "LetsEatModel")
        container.loadPersistentStores { (storeDesc, error) in
            guard error == nil else {
                print(error?.localizedDescription as Any)
                return
            }
        }
        
        super.init()
    } 
    
    func addReview(_ item:ReviewItem) {
        let review = Review(context: container.viewContext)
        if let rating = item.rating { review.rating = rating }
        review.name = item.name
        review.date = NSDate()
        review.customerReview = item.customerReview
        review.photo = item.photoData
        review.uuid = item.uuid
        
        if let id = item.restaurantID {
            review.restaurantID = Int32(id)
            save()
        }
        
        
    }
    
    private func save() {
        do {
            if container.viewContext.hasChanges {
                try container.viewContext.save()
                
                
            }
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
    
    func fetchReviews(by identifier:Int) -> [ReviewItem] {
        let moc = container.viewContext
        let request:NSFetchRequest<Review> = Review.fetchRequest()
        let predicate = NSPredicate(format: "restaurantID = %i", Int32(identifier))
        
        var items:[ReviewItem] = []
        
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        request.predicate = predicate
        
        do {
            for data in try moc.fetch(request) {
                items.append(ReviewItem(data: data))
            }
            
            return items
            
        } catch {
            fatalError("Failed to fetch reviews: \(error)")
        }
    }
}
