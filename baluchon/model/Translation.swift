//
//  Translation.swift
//  baluchon
//
//  Created by Guillaume Bourlart on 20/09/2022.
//

import Foundation

class Translation{
    
    
    
    var session: URLSession
    
    class TranslationError: Error {}
    static let error = TranslationError()
    
     init(session: URLSession){
        self.session = session
    }
    
    func getTranslation(text: String,source: String, target: String, then closure: @escaping (String?, Error?) -> Void){
        let rawUrl = "https://api-free.deepl.com/v2/translate" // static
        let key = "dd4d04ed-afe2-4bca-b6e4-f99a8149654b:fx"
        var urlComponent = URLComponents(string: rawUrl)
        //  We add arguments to the urlComponent
        urlComponent?.queryItems = [
            URLQueryItem(name: "source_lang", value: source),
            URLQueryItem(name: "target_lang", value: target),
            URLQueryItem(name: "text", value: text ),
            URLQueryItem(name: "auth_key", value: key)
        ]
        guard let url = urlComponent?.url else {
            closure(nil,nil) // a modifier
            return
        }
        // Create the request
        var request = URLRequest(url: url,timeoutInterval: Double.infinity)
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
              closure(nil, TranslationError())
              return
            }
            // check if there is Data
            guard let data = data else {
                closure(nil, TranslationError())
                return
            }
            do {
                // Try to convert the response into a Struct
                let translationResult: TranslationResult = try JSONDecoder().decode(TranslationResult.self, from: data)
                
                guard let text = translationResult.translations.first?.text else {
                    closure(nil, TranslationError())
                    return
                }
                
                closure(text, nil)
                
            }
            catch {
                // In case of error, we return it into the closure
                closure(nil, error)
            }
        }
        // Launch the request
        task.resume()
    }
}

// STUCTURE OF JSON RETURNED FROM API FOR CONVERSION
struct TranslationResult: Decodable {
    struct Translations: Decodable {
        let detected_source_language: String
        let text: String
    }
    let translations: [Translations]

}
