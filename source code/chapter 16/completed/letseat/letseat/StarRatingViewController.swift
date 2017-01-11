//
//  StarRatingViewController.swift
//  LetsEat
//
//  Created by Craig Clayton on 11/23/16.
//  Copyright © 2016 Craig Clayton. All rights reserved.
//

import UIKit

class StarRatingViewController: UIViewController {

    @IBOutlet var pickerView: UIPickerView!
    
    var selectedRating:Rating = Rating.zero
    var pickerDataSource = [Rating.five, Rating.fourHalf, Rating.four, Rating.threeHalf, Rating.three, Rating.twoHalf, Rating.two, Rating.oneHalf, Rating.one, Rating.half, Rating.zero]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialize()
    }

    func initialize() {
        setDefaults()
    }
    
    func setDefaults() {
        pickerView.dataSource = self
        pickerView.delegate = self
        if let index = pickerDataSource.index(of: selectedRating) {
            pickerView.selectRow(index, inComponent: 0, animated: false)
        }
    }
}

extension StarRatingViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let frame = CGRect(x: 0, y: 0, width: pickerView.rowSize(forComponent: component).width-10, height: pickerView.rowSize(forComponent: component).height)
        let ratingView = RatingView(frame: frame, value: pickerDataSource[row])
        
        return ratingView
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRating = pickerDataSource[row]
    }
}
