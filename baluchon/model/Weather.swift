//
//  weather.swift
//  baluchon
//
//  Created by Guillaume Bourlart on 20/09/2022.
//

import Foundation

class Weather{
    
    class WeatherError: Error {}
    static let error = WeatherError()
    
    var session: URLSession
    
     init(session: URLSession){
        self.session = session
    }
    
    func getWeather(lon: Double, lat: Double, then closure: @escaping (WeatherResult?,Error?) -> Void){
        
        let key = "2a6573791ec243777a308ff413f20180"
        let rawUrl = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&lang=fr&units=metric&appid=\(key)"
        guard let url = URL(string: rawUrl) else {
            closure(nil, WeatherError())
            return
        }
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        // Create the URLsession
        let task = session.dataTask(with: request) { data, response, error in
            // In case of error, we return it into the closure
            if let error = error
            {
                closure(nil, error)
                return
            }
            // check if there is a 200 status code response
            guard let response = response as? HTTPURLResponse,
            response.statusCode == 200 else {
              closure(nil, WeatherError())
              return
            }
            // check if there is Data
            guard let data = data else {
                closure(nil, WeatherError())
                return
            }
            do {
                // Try to convert the response into a Struct
                let results: WeatherResult = try JSONDecoder().decode(WeatherResult.self, from: data)
                closure(results, nil)
            } catch {
                // In case of error, we return it into the closure
                closure(nil, error)
            }
        }
        // Launch the request
        task.resume()
    }
    
    
    // Format a unix date into a time HH:mm
    static func getDate(unix: Double, timeZoneSeconds: Int) -> String{
        let date: Date = Date(timeIntervalSince1970: unix)

        // Create Date Formatter
        let dateFormatter = DateFormatter()
        
        // Set Date/Time Style
        dateFormatter.timeStyle = DateFormatter.Style.short //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.none //Set date style
        dateFormatter.timeZone = .init(secondsFromGMT: timeZoneSeconds)
        dateFormatter.amSymbol = ""
        dateFormatter.pmSymbol = ""
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: date)
    }
    
    // when we switch the city, this function call the function "getWeather" to get new weather informations and return the result into a closure
    func selectedChanged(selected: Int, then closure: @escaping (WeatherResult?,Error?) -> Void){
        switch selected
            {
            case 0:
            getWeather(lon: -74.005941, lat: 40.712784,  then: closure)
            case 1:
            getWeather(lon: 2.3522219, lat:  48.856614, then: closure)
            default:
                print("error")
                break
            }
    }
    
}
// STUCTURE OF JSON RETURNED FROM API FOR WEATHER
struct WeatherResult: Decodable{
    var coord: [String: Double]
    struct Weather: Decodable{
        var id: Double
        var main: String
        var description: String
        var icon: String
    }
    var weather: [Weather]
    var base: String
    var main: [String: Double]
    var visibility: Int
    var wind: [String: Double]
    var clouds: [String: Double]
    var dt: Double
    struct Sys: Decodable{
        var type: Double
        var id: Double
        var country: String
        var sunrise: Double
        var sunset: Double
    }
    var sys: Sys
    var timezone: Int
    var id: Double
    var name: String
    var cod: Double
    
    
    
}



