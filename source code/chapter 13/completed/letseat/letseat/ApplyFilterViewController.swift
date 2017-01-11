//
//  ApplyFilterViewController.swift
//  LetsEat
//
//  Created by Craig Clayton on 11/23/16.
//  Copyright © 2016 Craig Clayton. All rights reserved.
//

import UIKit

class ApplyFilterViewController: UIViewController {

    var image: UIImage?
    var thumbnail: UIImage?
    let manager = FilterManager()
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var imgExample: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }

    func initialize() {
        manager.fetch()
        
        if let image = self.image, let thumb = self.thumbnail {
            createScrollContent(img: thumb)
            imgExample.image = image
        }
    }

    func createScrollContent(img:UIImage) {
        DispatchQueue.main.async {
            let size = CGFloat(102)
            var currentViewOffset = CGFloat(10)
            
            for index in 0..<self.manager.numberOfItems() {
                let item = self.manager.filterItemAtIndexPath(index: IndexPath(item: index, section: 0))
                let frame = CGRect(x: currentViewOffset, y: 0, width: size, height: 124)
                let subview = PhotoItem(frame: frame, image: img, item: item)
                subview.delegate = self
                
                self.scrollView.addSubview(subview)
                currentViewOffset += (size + 10)
            }
            
            self.scrollView.showsHorizontalScrollIndicator = false
            self.scrollView.contentSize = CGSize(width: CGFloat(self.manager.numberOfItems()) * 113, height: size)
        }
    }


}

extension ApplyFilterViewController: ImageFiltering, ImageFilteringDelegate {
    
    func filterSelected(item: FilterItem) {
        let filteredImg = image
        
        if let filterName = item.filter, let img = filteredImg {
            if filterName != "None" {
                imgExample.image = self.apply(filter: filterName, originalImage: img)
            }
            else {
                imgExample.image = img
            }
        }
    }

}

