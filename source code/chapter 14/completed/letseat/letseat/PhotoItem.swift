//
//  PhotoItem.swift
//  LetsEat
//
//  Created by Craig Clayton on 11/23/16.
//  Copyright © 2016 Craig Clayton. All rights reserved.
//

import UIKit

class PhotoItem: UIView, ImageFiltering {
    
    var imgThumb:UIImageView?
    var lblTitle:UILabel?
    var data:FilterItem?
    
    weak var delegate: ImageFilteringDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame:CGRect, image:UIImage, item:FilterItem) {
        
        super.init(frame: frame)
        
        setDefaults(item: item)
        createThumbnail(image: image, item: item)
        createLabel(item: item)
    }
    
    func setDefaults(item:FilterItem) {
        data = item
        let tap = UITapGestureRecognizer(target: self, action:#selector(thumbTapped))
        self.addGestureRecognizer(tap)
        self.backgroundColor = .clear
    }
    
    func createThumbnail(image:UIImage, item:FilterItem) {
        
        guard let filterName = item.filter else {
            return
        }
        
        if filterName != "None" {
            let filteredImg = apply(filter: filterName, originalImage: image)
            imgThumb = UIImageView(image: filteredImg)
        }
        else { imgThumb = UIImageView(image: image) }
        
        guard let thumb = imgThumb else {
            return
        }
        
        thumb.contentMode = .scaleAspectFill
        thumb.frame = CGRect(x: 0, y: 22, width: 102, height: 102)
        thumb.clipsToBounds = true
        
        addSubview(thumb)
    }
    
    func createLabel(item:FilterItem) {
        guard let displayName = item.name else {
            return
        }
        
        lblTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 102, height: 22))
        
        guard let label = lblTitle else {
            return
        }
        
        label.text = displayName
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textAlignment = .center
        label.backgroundColor = .clear
        
        
        addSubview(label)
    }
    
    func thumbTapped() {
        if let data = self.data {
            filterSelected(item: data)
        }
    }
    
    func filterSelected(item:FilterItem) {
        delegate?.filterSelected(item: item)
    }
}
