//
//  WeatherTestCase.swift
//  baluchonTests
//
//  Created by Guillaume Bourlart on 19/10/2022.
//

import XCTest
@testable import Baluchon

final class WeatherTestCase: XCTestCase {
    //----------------GETTING WEATHER----------------
    
    //ERRORS
    func testCurrenciesShouldPostFailedCallBackIfError(){
        //given
        let weather = Weather(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.FakeError()))
        //when
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weather.getWeather(lon: 2, lat: 2) { result, error in
            //then
            XCTAssertNil(result)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
        
    }
    
    func testCurrenciesShouldPostFailedCallBackIfIncorectResponse(){
        //given
        let weather = Weather(session: URLSessionFake(data: FakeResponseData.WeatherCorrectData, response: FakeResponseData.responseKO, error: nil))
        //when
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weather.getWeather(lon: 2, lat: 2) { result, error in
            //then
            XCTAssertNil(result)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
        
    }
    
    func testCurrenciesShouldPostFailedCallBackIfIncorectData(){
        //given
        let weather = Weather(session: URLSessionFake(data: FakeResponseData.IncorrectData, response: FakeResponseData.responseKO, error: nil))
        //when
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weather.getWeather(lon: 2, lat: 2) { result, error in
            //then
            XCTAssertNil(result)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
        
    }
    
    //SUCCESS
    
    func testGetCurrenciesShouldPostSuccessCallBackIfNoErrorAndCorrectData(){
        //given
        let weather = Weather(session: URLSessionFake(data: FakeResponseData.WeatherCorrectData, response: FakeResponseData.responseOk, error: nil))
        //when
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weather.getWeather(lon: 2, lat: 2) { result, error in
            //then
            XCTAssertNotNil(result)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
        
    }
    
    //Get date
    
    func testGetDateShouldReturnAResult(){
        //given
        let result = Weather.getDate(unix: 1670241889.0, timeZoneSeconds: -18000)
        //then
        XCTAssertTrue(result == "07:04")
    
    }
    
    //selected change
    
    func test1(){
        //given
        let weather = Weather(session: URLSession.shared)
        let _: () = weather.selectedChanged(selected: 0) { result, error in
            //then
            XCTAssertNotNil(result)
        }
        
    
    }
    
    func test2(){
        //given
        let weather = Weather(session: URLSession.shared)
        let _: () = weather.selectedChanged(selected: 3) { result, error in
            //then
            XCTAssertNotNil(error)
        }
        
    
    }
    
}
