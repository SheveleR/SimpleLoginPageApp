//
//  MockLoginPageVC.swift
//  SimpleLoginPageTests
//
//  Created by SheveleR on 16/03/2018.
//  Copyright © 2018 SheveleR. All rights reserved.
//

import Foundation

import XCTest
import Mockit
@testable import SimpleLoginPage

class MockLoginPageVC: LoginPageVCProtocol, Mock {
    let callHandler: CallHandler
    init (_ testCase: XCTestCase) {
        callHandler = CallHandlerImpl(withTestCase: testCase)
    }
    
    func instanceType() -> MockLoginPageVC {
        return self
    }
    
    func showErrorWithString(_ errorMsg: String) {
        let _ = callHandler.accept(nil, ofFunction: #function, atFile: #file, inLine: #line, withArgs: errorMsg)
    }
    
    func showWeatherAlert(_ weatherObject: WeatherObject) {
        let _ = callHandler.accept(nil, ofFunction: #function, atFile: #file, inLine: #line, withArgs: weatherObject)
    }
    
    func continueButtonEnabled(_ isEnabled: Bool) {
        let _ = callHandler.accept(nil, ofFunction: #function, atFile: #file, inLine: #line, withArgs: isEnabled)
    }
}
