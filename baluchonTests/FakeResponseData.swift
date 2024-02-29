//
//  FakeResponseData.swift
//  baluchonTests
//
//  Created by Guillaume Bourlart on 04/11/2022.
//

import Foundation

class FakeResponseData
{
    static let responseOk = HTTPURLResponse(url: URL(string: "https://google.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    static let responseKO = HTTPURLResponse(url: URL(string: "https://google.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)
    
    //ERROR
    
    class FakeError: Error {}
    static let error = FakeError()
    
    //CONVERSION
    
    static var ConversionCorrectData: Data {
        let bundle = Bundle(for: Self.self)
        let url = bundle.url(forResource: "Conversion", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var CurrenciesCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Currencies", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    // WEATHER
    
    static var WeatherCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    // TRANSLATION
    
    static var TranslationCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Translation", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    //INCORRECT DATA
    
    static let IncorrectData = "erreur".data(using: .utf8)!
    
    //static let imageData = "image".data(using: .utf8)
    
    
}
