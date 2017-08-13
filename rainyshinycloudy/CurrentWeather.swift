//
//  CurrentWeather.swift
//  rainyshinycloudy
//
//  Created by Leonardo Gouveia on 12/08/17.
//  Copyright © 2017 Leonardo Gouveia. All rights reserved.
//

import Foundation
import Alamofire

class CurrentWeather {
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter =  DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        let currentWeatherURL = getCurrentWeatherURL(lat: Location.sharedInstance.latitude, lon: Location.sharedInstance.longitude)
        
        Alamofire.request(currentWeatherURL).responseJSON { response in
            let result = response.result

            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                    //print("Nome cidade: \(name.capitalized)")
                }
                if let weather = dict["weather"]  as? [Dictionary<String, AnyObject>] {
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                        //print("Clima: \(main.capitalized)")
                    }
                    
                }
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let tempInKelvin = main["temp"] as? Double {
                        let tempInCelsius = convertKelvinToCelsius(tempInKelvin)
                        self._currentTemp = tempInCelsius
                        //print("Temp atual: \(tempInCelsius)")
                    }
                }
            }
            completed()
        }
        
        
    }
    
    
}
