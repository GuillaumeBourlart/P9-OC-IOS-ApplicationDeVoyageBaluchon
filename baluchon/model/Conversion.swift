//
//  conversion.swift
//  baluchon
//
//  Created by Guillaume Bourlart on 19/09/2022.
//

import Foundation

class Conversion {
    
    private static var lastResult: Double?
    var session: URLSession

    class ConversionError: Error {}
    static let error = ConversionError()
    
     init(session: URLSession){
        self.session = session
     }
    
    // GET ALL DIFFERENTS CURRENCIES
    func getCurrencies(then closure: @escaping ([String]?, Error?) -> Void){
        let url = "http://data.fixer.io/api/symbols?access_key=4edea6c75db1e7d3a8743b6233c4404a&format=1"
        // Create the request
        var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
        
        // mode
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
              closure(nil, ConversionError())
              return
            }
            // check if there is Data
            guard let data = data else {
                closure(nil, ConversionError())
                return
            }
            do {
                // Try to convert the response into a Struct
                let results: CurrencieResult = try JSONDecoder().decode(CurrencieResult.self, from: data)
                let allCurrencies = results
                    .symbols
                    .keys
                    .map{ element in
                        return element
                    }
                closure(allCurrencies, nil)
            } catch {
                // In case of error, we return it into the closure
                closure(nil, error)
            }
        }
        // Launch the request
        task.resume()
    }
    
    // Get the conversion required
    func convert(amount: String, from: String, to: String, then closure: @escaping (Double?, Error?) -> Void){
    
        let rawUrl = "http://data.fixer.io/api/convert"
        var urlComponent = URLComponents(string: rawUrl)
        //  We add arguments to the URL
        urlComponent?.queryItems = [
            URLQueryItem(name: "to", value: to),
            URLQueryItem(name: "from", value: from),
            URLQueryItem(name: "amount", value: amount),
            URLQueryItem(name: "apikey", value: "4edea6c75db1e7d3a8743b6233c4404a&format=1")
        ]
        guard let url = urlComponent?.url else {
            closure(nil,nil)
            return
        }
        // Create the request
        var request = URLRequest(url: url ,timeoutInterval: Double.infinity)
        // Mode
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
              closure(nil, ConversionError())
              return
            }
            // check if there is Data
          guard let data = data else {
            closure(nil, ConversionError())
            return
          }
            do {
                // Try to convert the response into a Struct
                let conversion: ConversionResult = try JSONDecoder().decode(ConversionResult.self, from: data)
                closure(conversion.result, nil)
                
            } catch {
                // In case of error, we return it into the closure
                closure(nil, error)
                
            }
        }
        // Launch the request
        task.resume()
    }
}


// STUCTURE OF JSON RETURNED FROM API FOR CURRENCIES
struct CurrencieResult: Decodable {
     let success: Bool
    let symbols: [String: String]
    
}

// STUCTURE OF JSON RETURNED FROM API FOR CONVERSION
struct ConversionResult: Decodable {
    struct Query: Decodable {
        let from: String
        let to: String
        let amount: Double
    }
    let date: String
    let info: [String: Double]
    let query: Query
    let result: Double
    let success: Bool
    struct Error: Decodable {
        let code: Double
        let type: String
        let info: String
    }

}
