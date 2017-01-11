//
//  RestaurantListViewController.swift
//  LetsEat
//
//  Created by Craig Clayton on 11/1/16.
//  Copyright © 2016 Craig Clayton. All rights reserved.
//

import UIKit
import LetsEatDataKit

class RestaurantListViewController: UIViewController {
    
    @IBOutlet var collectionView:UICollectionView!
    let manager = RestaurantDataManager()
    
    var selectedRestaurant:RestaurantItem?
    var selectedCity:String?
    var selectedType:String?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let location = selectedCity, let type = selectedType else {
            return
        }
        
        manager.fetch(by: location, withFilter: type, completionHandler: {
            collectionView.reloadData()
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case Segue.showDetail.rawValue:
                showRestaurantDetail(segue: segue)
            default:
                print("Segue not added")
            }
        }
    }
    
    func initialize() {
        if Device.isPad { setupCollectionView() }
    }

    func setupCollectionView() {
        let flow = UICollectionViewFlowLayout()
        
        flow.sectionInset = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 7
        
        collectionView?.collectionViewLayout = flow
    }
    
    func showRestaurantDetail(segue:UIStoryboardSegue) {
        if let viewController = segue.destination as? RestaurantDetailViewController, let index = collectionView.indexPathsForSelectedItems?.first {
            selectedRestaurant = manager.restaurantItem(at: index)
            viewController.selectedRestaurant = selectedRestaurant
        }
    }

}

extension RestaurantListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if Device.isPhone {
            
            let cellWidth = collectionView.frame.size.width
            return CGSize(width: cellWidth, height: 135)
        }
        else {
            
            let screenRect = collectionView.frame.size.width
            let screenWidth = screenRect - 21
            let cellWidth = screenWidth / 2.0
            
            return CGSize(width: cellWidth, height: 135)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.reloadData()
    }
}











