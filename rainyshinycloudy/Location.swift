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
}
