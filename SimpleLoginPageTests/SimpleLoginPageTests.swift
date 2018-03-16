//
//  SimpleLoginPageTests.swift
//  SimpleLoginPageTests
//
//  Created by SheveleR on 15/03/2018.
//  Copyright © 2018 SheveleR. All rights reserved.
//

import XCTest
import Mockit
@testable import SimpleLoginPage

class SimpleLoginPageTests: XCTestCase {
    var presenter: SLPLoginPagePresenter!
    var mockVC: MockLoginPageVC!
    var mockModel: MockLoginPageModel!
    var vm: SLPLoginPageVM!
    var getShotBlock: ((WeatherObject, SimpleCustomError?)->Void)?
    
    override func setUp() {
        super.setUp()
        mockVC = MockLoginPageVC.init(self)
        mockModel = MockLoginPageModel.init(testCase: self)
        presenter = SLPLoginPagePresenter.init(mockVC, mockModel, SLPLoginPageVM())
    }
    
    func testLoginTappedOK() {
        let loginBlock = presenter.loginTappedBlock!
        let weatherObject = WeatherObject.init(AnyValue.string, AnyValue.string)
        
        mockModel.when().call(withReturnValue: mockModel.fakeLoginRequest(AnyValue.string, password: AnyValue.string, loginBlock), andArgumentMatching: [Anything(),Anything(), Anything()]).thenDo { (res: [Any?]) in
            loginBlock(weatherObject, nil)
        }
        
        presenter.loginTapped(AnyValue.string, AnyValue.string )
        
        mockModel.verify(verificationMode: Once()).fakeLoginRequest(AnyValue.string, password: AnyValue.string, loginBlock)
        mockVC.verify(verificationMode: Once()).showWeatherAlert(weatherObject)
    }
    
    func testLoginTappedError() {
        let loginBlock = presenter.loginTappedBlock!
        let simpleError = SimpleCustomError.init(withErrorLocalizedString: AnyValue.string)
        
        mockModel.when().call(withReturnValue: mockModel.fakeLoginRequest(AnyValue.string, password: AnyValue.string, loginBlock), andArgumentMatching: [Anything(),Anything(), Anything()]).thenDo { (res: [Any?]) in
            loginBlock(nil, simpleError)
        }
        
        presenter.loginTapped(AnyValue.string, AnyValue.string )
        
        mockModel.verify(verificationMode: Once()).fakeLoginRequest(AnyValue.string, password: AnyValue.string, loginBlock)
        mockVC.verify(verificationMode: Once()).showErrorWithString(AnyValue.string)
    }
    
    func testIsEmailValid() {
        presenter.isValidEmail(AnyValue.string, AnyValue.bool)
        
        mockVC.verify(verificationMode: Once()).continueButtonEnabled(AnyValue.bool)
    }
    
    func testIsPasswordValid() {
        presenter.isValidEmail(AnyValue.string, AnyValue.bool)
        
        mockVC.verify(verificationMode: Once()).continueButtonEnabled(AnyValue.bool)
    }
    
    func testCreateAccountTapped() {
        presenter.createAccountTapped()
        
        mockVC.verify(verificationMode: Once()).showErrorWithString(AnyValue.string)
    }
    
    func testForgetPasswordTapped() {
        presenter.forgetPasswordTapped()
        
        mockVC.verify(verificationMode: Once()).showErrorWithString(AnyValue.string)
    }
}

