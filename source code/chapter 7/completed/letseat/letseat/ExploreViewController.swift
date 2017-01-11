//
//  ExploreViewController.swift
//  LetsEat
//
//  Created by Craig Clayton on 10/31/16.
//  Copyright © 2016 Craig Clayton. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet var collectionView:UICollectionView!
    let manager = ExploreDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        manager.fetch()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manager.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exploreCell", for: indexPath) as! ExploreCell
        
        let item = manager.explore(at: indexPath)
        if let name = item.name { cell.lblName.text = name }
        if let image = item.image { cell.imgExplore.image = UIImage(named: image) }

        return cell
    }
}










