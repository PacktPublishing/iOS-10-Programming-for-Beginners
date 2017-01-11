//
//  ReviewListViewController.swift
//  LetsEat
//
//  Created by Craig Clayton on 11/20/16.
//  Copyright © 2016 Craig Clayton. All rights reserved.
//

import UIKit

class ReviewListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var selectedRestaurantID:Int?
    let manager = ReviewDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    func initialize() {
        if let id = selectedRestaurantID {
            manager.fetchReview(by: id)
            setupTableView()
        }
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.estimatedRowHeight = 128
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ReviewListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as? ReviewCell else {return UITableViewCell()}
        
        let review = manager.reviewItem(at:indexPath)
        cell.lblUser.text = review.name
        cell.lblReview.text = review.customerReview
        cell.lblDate.text = review.displayDate
        
        if let rating = review.rating { cell.imgRating.image = UIImage(named: Rating.image(rating: rating)) }
        if let photo = review.photo {
            cell.imgReview.image = photo
        }
        
        return cell
    }
}
