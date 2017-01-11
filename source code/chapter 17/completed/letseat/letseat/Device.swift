//
//  Device.swift
//  LetsEat
//
//  Created by Craig Clayton on 11/24/16.
//  Copyright © 2016 Craig Clayton. All rights reserved.
//

import UIKit

struct Device {
    
    static var currentDevice: UIDevice {
        struct Singleton {
            static let device = UIDevice.current
        }
        return Singleton.device
    }
    
    static var isPhone: Bool {
        return currentDevice.userInterfaceIdiom == .phone
    }
    
    static var isPad: Bool {
        return currentDevice.userInterfaceIdiom == .pad
    }
}
