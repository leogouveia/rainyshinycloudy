//
//  WeatherCell.swift
//  rainyshinycloudy
//
//  Created by Leonardo Gouveia on 12/08/17.
//  Copyright © 2017 Leonardo Gouveia. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    func configureCell(_ forecast: Forecast) {
        maxTempLabel.text = String(format: "%.1fºC", forecast.highTemp)
        minTempLabel.text = String(format: "%.1fºC", forecast.lowTemp)
        dayLabel.text = forecast.date
        weatherImage.image = UIImage(named: forecast.weatherType)
        weatherLabel.text = forecast.weatherType
        
    }
    
}
