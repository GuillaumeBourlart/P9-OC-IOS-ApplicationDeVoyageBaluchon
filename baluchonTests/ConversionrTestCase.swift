//
//  ConversionrTestCase.swift
//  baluchonTests
//
//  Created by Guillaume Bourlart on 19/10/2022.
//

import XCTest
@testable import Baluchon

final class ConversionrTestCase: XCTestCase {
    
    var conversionController = ConversionViewController()
    private var allCurrencies: [String] = []
    
    
    //----------------GETTING CURRENCIES----------------
    
    // API CALL ERRORS
    func testCurrenciesShouldPostFailedCallBackIfError(){
        //given
        let conversion = Conversion(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.FakeError()))
        //when
        let expectation = XCTestExpectation(description: "Wait for queue change")
        conversion.getCurrencies { currencies, error in
            //then
            XCTAssertNil(currencies)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
        
    }
    
    func testCurrenciesShouldPostFailedCallBackIfIncorectResponse(){
        //given
        let conversion = Conversion(session: URLSessionFake(data: FakeResponseData.CurrenciesCorrectData, response: FakeResponseData.responseKO, error: nil))
        //when
        let expectation = XCTestExpectation(description: "Wait for queue change")
        conversion.getCurrencies { currencies, error in
            //then
            XCTAssertNil(currencies)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
        
    }
    
    func testCurrenciesShouldPostFailedCallBackIfIncorectData(){
        //given
        let conversion = Conversion(session: URLSessionFake(data: FakeResponseData.IncorrectData, response: FakeResponseData.responseKO, error: nil))
        //when
        let expectation = XCTestExpectation(description: "Wait for queue change")
        conversion.getCurrencies { currencies, error in
            //then
            XCTAssertNil(currencies)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
        
    }
    
    
    
    //API CALL SUCCESS
    
    func testGetCurrenciesShouldPostSuccessCallBackIfNoErrorAndCorrectData(){
        //given
        let conversion = Conversion(session: URLSessionFake(data: FakeResponseData.CurrenciesCorrectData, response: FakeResponseData.responseOk, error: nil))
        //when
        let expectation = XCTestExpectation(description: "Wait for queue change")
        conversion.getCurrencies { currencies, error in
            //then
            XCTAssertNotNil(currencies)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    
    
    
    //----------------CONVERTING----------------
    
    //API CALL ERRORS
    func testConversionShouldPostFailedCallBackIfError(){
        //given
        let conversion = Conversion(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.FakeError()))
        //when
        let expectation = XCTestExpectation(description: "Wait for queue change")
        conversion.convert(amount: "20", from: "USD", to: "EUR") { response, error in
            //then
            XCTAssertNil(response)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
        
    }
    
    func testCoversionShouldPostFailedCallBackIfIncorectResponse(){
        //given
        let conversion = Conversion(session: URLSessionFake(data: FakeResponseData.ConversionCorrectData, response: FakeResponseData.responseKO, error: nil))
        //when
        let expectation = XCTestExpectation(description: "Wait for queue change")
        conversion.convert(amount: "20", from: "USD", to: "EUR") { response, error in
            //then
            XCTAssertNil(response)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
        
    }
    
    func testCoversionShouldPostFailedCallBackIfIncorectData(){
        //given
        let conversion = Conversion(session: URLSessionFake(data: FakeResponseData.IncorrectData, response: FakeResponseData.responseOk, error: nil))
        //when
        let expectation = XCTestExpectation(description: "Wait for queue change")
        conversion.convert(amount: "20", from: "USD", to: "EUR") { response, error in
            //then
            XCTAssertNil(response)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
    
    }
    
    //API CALL SUCCESS
    func testConvertShouldPostSuccessCallBackIfNoErrorAndCorrectData(){
        //given
        let conversion = Conversion(session: URLSessionFake(data: FakeResponseData.ConversionCorrectData, response: FakeResponseData.responseOk, error: nil))
        //when
        let expectation = XCTestExpectation(description: "Wait for queue change")
        conversion.convert(amount: "20", from: "USD", to: "EUR") { response, error in
            //then
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
    
    }
    
    

}
