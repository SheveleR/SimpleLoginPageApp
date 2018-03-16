//
//  MockLoginPageModel.swift
//  SimpleLoginPageTests
//
//  Created by SheveleR on 16/03/2018.
//  Copyright © 2018 SheveleR. All rights reserved.
//

import Foundation

import XCTest
import Mockit
@testable import SimpleLoginPage

class MockLoginPageModel: LoginPageModelProtocol, Mock {
    let callHandler: CallHandler
    
    init(testCase: XCTestCase) {
        callHandler = CallHandlerImpl(withTestCase: testCase)
    }
    func instanceType() -> MockLoginPageModel {
        return self
    }
    
    func fakeLoginRequest(_ email: String, password: String, _ callback: ((WeatherObject?, SimpleCustomError?) -> Void)?) {
        let _ = callHandler.accept(nil, ofFunction: #function, atFile: #file, inLine: #line, withArgs: email, password, callback)
    }
}
