//
//  Constants.swift
//  rainyshinycloudy
//
//  Created by Leonardo Gouveia on 12/08/17.
//  Copyright © 2017 Leonardo Gouveia. All rights reserved.
//

import UIKit

let BASE_URL = "http://api.openweathermap.org/data/2.5/"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "c4392073ed6c8234f0709028b676b689"
let WEATHER_URL = "\(BASE_URL)weather?"
let FORECAST_URL = "\(BASE_URL)forecast/daily?"
let FORECAST_COUNTER = "&cnt="
let CNT = "7"
let LAT = "41.6561"
let LON = "-0.8774"

// api.openweathermap.org/data/2.5/forecast/daily?lat={lat}&lon={lon}&cnt={cnt}

let CURRENT_WEATHER_URL = "\(WEATHER_URL)\(LATITUDE)\(LAT)\(LONGITUDE)\(LON)\(APP_ID)\(API_KEY)"
let FORECAST_WEATHER_URL = "\(FORECAST_URL)\(LATITUDE)\(LAT)\(LONGITUDE)\(LON)\(FORECAST_COUNTER)\(CNT)\(APP_ID)\(API_KEY)"

typealias DownloadComplete = () -> ()

func getCurrentWeatherURL(lat: Double, lon: Double) -> URL {

    return URL(string: "\(WEATHER_URL)\(LATITUDE)\(lat)\(LONGITUDE)\(lon)\(APP_ID)\(API_KEY)")!
    
}

func getForecastWeatherURL(lat: Double, lon: Double) -> URL {
    return URL(string: "\(FORECAST_URL)\(LATITUDE)\(lat)\(LONGITUDE)\(lon)\(FORECAST_COUNTER)\(CNT)\(APP_ID)\(API_KEY)")!
}

func convertKelvinToCelsius(_ tempInKelvin: Double) -> Double {
    return tempInKelvin - 273
}
