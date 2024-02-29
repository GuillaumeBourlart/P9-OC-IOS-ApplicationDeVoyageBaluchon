//
//  ViewController.swift
//  baluchon
//
//  Created by Guillaume Bourlart on 19/09/2022.
//

import UIKit

class WeatherViewController: UIViewController{
    
    @IBOutlet weak var degrees: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var feels_like: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var visibility: UILabel!
    @IBOutlet weak var wind_speed: UILabel!
    @IBOutlet weak var temp_min: UILabel!
    @IBOutlet weak var temp_max: UILabel!
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!
    @IBOutlet weak var switchButton: UISegmentedControl!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var background: UIImageView!
    
    
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    }
    
    var weather = Weather(session: URLSession.shared)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        improveDesign()
        // Do any additional setup after loading the view.
        switchCity(switchButton as Any)
    }
    
    // function called when we switch from Paris to New York and vis versa
    @IBAction func switchCity(_ sender: Any) {
        
        // We call the function that switch from Paris' weather information to new York's weather information and vis versa
        weather.selectedChanged(selected: switchButton.selectedSegmentIndex) {weatherResults,error in
            // If we get successfully weather informations of the new city, we call the function that display all those informations
            if let weather = weatherResults {
                self.displayInformations(weather: weather)
            }
            // In case of error, we display an error
            if error != nil {
                DispatchQueue.main.async {
                    let alert = Alert.createAlert(with: "il y a eu une erreur")
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    
    // Function that display all informations of current city's weather
    func displayInformations(weather: WeatherResult)  {
        
        DispatchQueue.main.async {
            self.degrees.text = String(Int(weather.main["temp"] ?? 1)) + " °C"
            self.city.text = weather.name
            self.pressure.text = "Pression: " + String(weather.main["pressure"] ?? 1) + " hPa"
            self.feels_like.text = "Ressenti: " + String(Int(weather.main["feels_like"] ?? 1)) + " °C"
            
            self.desc.text = String(weather.weather[0].description)
            self.humidity.text = "Humidité: " + String(weather.main["humidity"] ?? 1) + " %"
            self.visibility.text = "Visibilité: " + String(weather.main["visibility"] ?? 1) + " km"
            self.wind_speed.text = "Vitesse du vent: " + String(weather.wind["speed"] ?? 1) + " mètres/sec"
            self.temp_min.text = "" + String(Int(weather.main["temp_min"] ?? 1)) + " °C"
            self.temp_max.text = "" + String(Int(weather.main["temp_max"] ?? 1)) + " °C"
            self.sunrise.text = Weather.getDate(unix: weather.sys.sunrise, timeZoneSeconds: weather.timezone)
            self.sunset.text = Weather.getDate(unix: weather.sys.sunset, timeZoneSeconds: weather.timezone)
            
        }
    }
    
    func improveDesign(){
        self.sunrise.layer.cornerRadius = 10
        self.sunset.layer.cornerRadius = 10
        self.stackView.layer.cornerRadius = 10
    }
}
