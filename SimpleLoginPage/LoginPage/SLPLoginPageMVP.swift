//
//  SLPLoginPageMVP.swift
//  SimpleLoginPage
//
//  Created by SheveleR on 15/03/2018.
//  Copyright © 2018 SheveleR. All rights reserved.
//

import Foundation

protocol LoginPageVCProtocol {
    func showErrorWithString(_ errorMsg: String)
    func showWeatherAlert(_ weatherObject: WeatherObject)
    func continueButtonEnabled(_ isEnabled: Bool)
}

protocol LoginPagePresenterProtocol {
    init(_ viewControlelr: LoginPageVCProtocol, _ model: LoginPageModelProtocol, _ viewModel: SLPLoginPageVM)
    func isValidEmail(_ emailString: String, _ isEndEditing: Bool)
    func isPasswordValid(_ passwordString: String, _ isEndEditing: Bool)
    func loginTapped(_ email: String, _ password: String)
    func forgetPasswordTapped()
    func createAccountTapped()
}

protocol LoginPageModelProtocol {
    func fakeLoginRequest(_ email: String, password: String, _ callback: ((WeatherObject?, SimpleCustomError?)->Void)?)
}
