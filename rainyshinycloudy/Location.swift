//
//  Location.swift
//  rainyshinycloudy
//
//  Created by Leonardo Gouveia on 12/08/17.
//  Copyright © 2017 Leonardo Gouveia. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    
    var _latitude: Double!
    var _longitude: Double!
    var _updatedAt: Date!
    
    var latitude: Double {
        if _latitude == nil {
            _latitude = 41.6561
        }
        return _latitude
    }
    
    var longitude: Double {
        if _longitude == nil {
            _longitude = -0.8774
        }
        return _longitude
    }
    
    var updatedAt: Date {
        if _updatedAt == nil {
            _updatedAt = Date()
        }
        return _updatedAt
    }
}
