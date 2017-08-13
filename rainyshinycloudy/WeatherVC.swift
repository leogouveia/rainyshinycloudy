//
//  ViewController.swift
//  rainyshinycloudy
//
//  Created by Leonardo Gouveia on 11/08/17.
//  Copyright © 2017 Leonardo Gouveia. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
   
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather = CurrentWeather()
    var forecast = Forecast()
    var forecasts = [Forecast]()
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    var timeInSecsToUpdate = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        resetMainUI()
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorization()
        updateLocation()
        //locationTimer()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //locationManager.stopUpdatingLocation()
        print("Error: ", error)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations")
        if let location = locations.last {
            updateLocationData(location: location)
            print("location: \(location)")
            
            manager.stopUpdatingLocation()
        }
    }
    
    func locationTimer() {
        Timer.scheduledTimer(timeInterval: TimeInterval(timeInSecsToUpdate), target: self, selector: #selector(self.updateLocation), userInfo: nil, repeats: true)
    }
    
    
    func updateLocation() {
        print("updating location...")
        locationManager.startUpdatingLocation()
    }
    
    func updateLocationData(location: CLLocation) {
        if (Location.sharedInstance.latitude != location.coordinate.latitude
            && Location.sharedInstance.longitude != location.coordinate.longitude
            ) {
            Location.sharedInstance._latitude = location.coordinate.latitude
            Location.sharedInstance._longitude = location.coordinate.longitude
            updateWeather()
        }
    }
    
    func updateWeather() {
        currentWeather.downloadWeatherDetails {
            self.updateMainUI()
        }
        forecast.downloadData { forecasts in
            self.forecasts = forecasts!
            self.forecasts.removeFirst()
            self.tableView.reloadData()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast)
            return cell
        } else {
            return WeatherCell()
        }
        
        
    }
    
    func updateMainUI() {
        dateLabel.text = currentWeather.date
        currentTempLabel.text = String(format: "%02dºC", Int(round(currentWeather.currentTemp)))
        locationLabel.text = currentWeather.cityName
        currentWeatherLabel.text = currentWeather.weatherType
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }
    
    func resetMainUI() {
        locationLabel.text = ""
        currentWeatherLabel.text = ""
        dateLabel.text = ""
        currentTempLabel.text = ""
    }
    
    
    func checkLocationAuthorization() {
        if !CLLocationManager.locationServicesEnabled() {
            showNotAuthorizedAlert(message: "You are not using location services, so this app won't work")
        } else {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                showNotAuthorizedAlert(message: "You did not authorized this application to use your location, so it won't work...")
            default:
                print("ok access")
            }
            
        }
    }
    
    func showNotAuthorizedAlert(message: String) {
        let title = "Alert"
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            exit(0)
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    

}

