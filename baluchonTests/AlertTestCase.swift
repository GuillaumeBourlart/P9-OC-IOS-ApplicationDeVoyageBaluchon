//
//  ErrorTestCase.swift
//  BaluchonTests
//
//  Created by Guillaume Bourlart on 05/12/2022.
//

import XCTest

@testable import Baluchon

final class AlertTestCase: XCTestCase {

    func testAlertShouldBeReturnedWhenClassIsCalled(){
        //given
        let alert: UIAlertController
        //when
        alert = Alert.createAlert(with: "an error occured")
        //then
        
        XCTAssertNotNil(alert)
        
        
    }

}
