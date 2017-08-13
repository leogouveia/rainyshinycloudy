//
//  Forecast.swift
//  rainyshinycloudy
//
//  Created by Leonardo Gouveia on 12/08/17.
//  Copyright © 2017 Leonardo Gouveia. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
    var _date: String!
    var _weatherType: String!
    var _highTemp: Double!
    var _lowTemp: Double!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp: Double {
        if _highTemp == nil {
            _highTemp = 0.0
        }
        return _highTemp
    }
    
    var lowTemp: Double {
        if _lowTemp == nil {
            _lowTemp = 0.0
        }
        return _lowTemp
    }
    init() {
        
    }
    
    init(weatherDictionary: Dictionary<String, AnyObject>) {
    
            
        if let temp = weatherDictionary["temp"] as? Dictionary<String, AnyObject> {

            if let tempMin = temp["min"] as? Double {
                self._lowTemp = convertKelvinToCelsius(tempMin)
                
            }
            if let tempMax = temp["max"] as? Double {
                self._highTemp = convertKelvinToCelsius(tempMax)
                
            }
            
        }
        
        
        if let weatherList = weatherDictionary["weather"] as? [Dictionary<String, AnyObject>] {

            if let main = weatherList[0]["main"] as? String {
                self._weatherType = main
            }
            
        }
        
        if let date = weatherDictionary["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            
            self._date = dateFormatter.string(from: unixConvertedDate)
                        
        }
    }
    
    func downloadData(completed: @escaping ([Forecast]?) -> ()) {
        let currentWeatherURL = getForecastWeatherURL(lat: Location.sharedInstance.latitude, lon: Location.sharedInstance.longitude)
                
        Alamofire.request(currentWeatherURL).responseJSON { response in
            var forecasts = [Forecast]()
            let result = response.result
            
            guard let dict = result.value as? Dictionary<String, AnyObject>,
                let list = dict["list"] as? [Dictionary<String, AnyObject>] else {
                completed(nil)
                return
            }
            
            
            for obj in list {
                forecasts.append(Forecast(weatherDictionary: obj))
            }
            
            completed(forecasts)
        }
        
    }

}
