//
//  TranslationTestCase.swift
//  baluchonTests
//
//  Created by Guillaume Bourlart on 19/10/2022.
//

import XCTest
@testable import Baluchon

final class TranslationTestCase: XCTestCase {
    //----------------GETTING TRANSLATION----------------
    
    //ERRORS
    func testCurrenciesShouldPostFailedCallBackIfError(){
        //given
        let translation = Translation(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.FakeError()))
        //when
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translation.getTranslation(text: "EEE", source: "EN", target: "FR"){ result, error in
            //then
            XCTAssertNil(result)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
        
    }
    
    func testCurrenciesShouldPostFailedCallBackIfIncorectResponse(){
       
        //given
        let translation = Translation(session: URLSessionFake(data: FakeResponseData.TranslationCorrectData, response: FakeResponseData.responseKO, error: nil))
        //when
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translation.getTranslation(text: "EEE", source: "EN", target: "FR"){ result, error in
            //then
            XCTAssertNil(result)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
        
    }
    
    func testCurrenciesShouldPostFailedCallBackIfIncorectData(){
       
        //given
        let translation = Translation(session: URLSessionFake(data: FakeResponseData.IncorrectData, response: FakeResponseData.responseKO, error: nil))
        //when
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translation.getTranslation(text: "EEE", source: "EN", target: "FR"){ result, error in
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
        let translation = Translation(session: URLSessionFake(data: FakeResponseData.TranslationCorrectData, response: FakeResponseData.responseOk, error: nil))
        //when
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translation.getTranslation(text: "EEE", source: "EN", target: "FR"){ result, error in
            //then
            XCTAssertNotNil(result)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
        
    }
    
    
}
