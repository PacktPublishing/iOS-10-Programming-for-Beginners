//
//  RestaurantListViewController.swift
//  LetsEat
//
//  Created by Craig Clayton on 11/1/16.
//  Copyright © 2016 Craig Clayton. All rights reserved.
//

import UIKit

class RestaurantListViewController: UIViewController {
    
    @IBOutlet var collectionView:UICollectionView!
    let manager = RestaurantDataManager()

    var selectedCity:String?
    var selectedType:String?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let location = selectedCity, let type = selectedType else {
            return
        }
        
        manager.fetch(by: location, withFilter: type, completionHandler: {
            collectionView.reloadData()
        })
    }
}

extension RestaurantListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manager.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restaurantListCell", for: indexPath) as! RestaurantCell
        let item = manager.restaurantItem(at: indexPath)
        
        if let name = item.name { cell.lblTitle.text = name }
        if let city = item.city { cell.lblCity.text = city }
        if let cuisine = item.cuisine { cell.lblCuisine.text = cuisine }
        
        return cell
    }
}











