//
//  MessagesViewController.swift
//  MessageApp
//
//  Created by Craig Clayton on 11/25/16.
//  Copyright © 2016 Craig Clayton. All rights reserved.
//

import UIKit
import Messages
import LetsEatDataKit

class MessagesViewController: MSMessagesAppViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    let manager = RestaurantDataManager()
    var selectedRestaurant:RestaurantItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initialize() {
        setupCollectionView()
        
        manager.fetch(by: "Chicago", completionHandler: {
            
            self.collectionView.reloadData()
        })
    }
    
    func setupCollectionView() {
        let flow = UICollectionViewFlowLayout()
        
        flow.sectionInset = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 7
        
        collectionView.collectionViewLayout = flow
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func createMessage(with restaurant:RestaurantItem) {
        if let conversation = activeConversation {
            let layout = MSMessageTemplateLayout()
            layout.image = UIImage(named: "restaurant-detail")
            layout.caption = "Table for 7, tonight at 10:00 PM"
            layout.imageTitle = restaurant.name
            layout.imageSubtitle = restaurant.cuisine
            
            let message = MSMessage()
            message.layout = layout
            message.url = URL(string: "emptyURL")
            
            conversation.insert(message, completionHandler: { (error: Error?)  in
                if error != nil {
                    print("there was an error \(error)")
                }
                else {
                    self.requestPresentationStyle(.compact)
                }
            })
        }
    }
    
    // MARK: - Conversation Handling
    
    override func willBecomeActive(with conversation: MSConversation) {
        
        
    }
    
    override func didResignActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the active to inactive state.
        // This will happen when the user dissmises the extension, changes to a different
        // conversation or quits Messages.
        
        // Use this method to release shared resources, save user data, invalidate timers,
        // and store enough state information to restore your extension to its current state
        // in case it is terminated later.
    }
   
    override func didReceive(_ message: MSMessage, conversation: MSConversation) {
        requestPresentationStyle(.expanded)
    }
    
    override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user taps the send button.
    }
    
    override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user deletes the message without sending it.
    
        // Use this to clean up state related to the deleted message.
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called before the extension transitions to a new presentation style.
    
        // Use this method to prepare for the change in presentation style.
    }
    
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called after the extension transitions to a new presentation style.
    
        // Use this method to finalize any behaviors associated with the change in presentation style.
    }
}

extension MessagesViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manager.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restaurantCell", for: indexPath) as! RestaurantMessageCell
        let item = manager.restaurantItem(at: indexPath)
        
        if let name = item.name { cell.lblTitle.text = name }
        if let city = item.city { cell.lblCity.text = city }
        if let cuisine = item.cuisine { cell.lblCuisine.text = cuisine }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = self.collectionView.frame.size.width - 14
        
        return CGSize(width: cellWidth, height: 78)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedRestaurant = manager.restaurantItem(at: indexPath)
        guard let restaurant = selectedRestaurant else { return }
        
        createMessage(with: restaurant)
    }
}
