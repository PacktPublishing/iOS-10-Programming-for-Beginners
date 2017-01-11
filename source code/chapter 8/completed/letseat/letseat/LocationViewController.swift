//
//  LocationViewController.swift
//  LetsEat
//
//  Created by Craig Clayton on 11/10/16.
//  Copyright © 2016 Craig Clayton. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController, UITableViewDataSource {

    @IBOutlet var tableView:UITableView!
    
    let manager = LocationDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.fetch()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.numberOfItems()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = manager.locationItem(at: indexPath)
        
        return cell
    }
}
