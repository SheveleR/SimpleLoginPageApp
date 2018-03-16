//
//  LPPresenter.swift
//  SimpleLoginPage
//
//  Created by SheveleR on 15/03/2018.
//  Copyright © 2018 SheveleR. All rights reserved.
//

import Foundation

class SLPLoginPagePresenter: LoginPagePresenterProtocol {
    var view: LoginPageVCProtocol!
    var model: LoginPageModelProtocol!
    var vm: SLPLoginPageVM!
    var loginTappedBlock: ((WeatherObject?, SimpleCustomError?)->Void)?
    
    required init(_ viewControlelr: LoginPageVCProtocol, _ model: LoginPageModelProtocol, _ viewModel: SLPLoginPageVM) {
        self.view = viewControlelr
        self.model = model
        self.vm = viewModel
        loginTappedBlock = { (weatherObject, err) in
            if let error = err {
                self.view.showErrorWithString(error.errorMsg!)
            }
            else if let weatherObj = weatherObject {
                self.view.showWeatherAlert(weatherObj)
            }
        }
    }
    
    // Обработка нажатия кнопки "Войти"
    func loginTapped(_ email: String, _ password: String) {
        model.fakeLoginRequest(email, password: password, loginTappedBlock!)
    }
    
    // Обработка нажатия кнопки "Забыли пароль"
    func forgetPasswordTapped() {
        view.showErrorWithString("Нужно было записывать!")
    }
    
    // Обработка нажатия кнопки "У меня еще нет аккаунта. Создать"
    func createAccountTapped() {
        view.showErrorWithString("Зачем тебе новый аккаунт, когда ты можешь узнать про погоду?")
    }
    
    // Проверка валидности поля email
    func isValidEmail(_ emailString: String, _ isEndEditing: Bool) {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailTest.evaluate(with: emailString) {
            vm.emailString = emailString
            vm.isEmailValid = true
            checkLoginButton()
        }
        else if isEndEditing {
            vm.isEmailValid = false
            view.showErrorWithString("Такого пользователя не существует")
        }
        else {
            vm.isEmailValid = false
        }
        checkLoginButton()
    }
    
    // Проверка валидности поля password
    func isPasswordValid(_ passwordString: String, _ isEndEditing: Bool) {
        let passwordRegEx = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{6,}$"
    
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        if passwordTest.evaluate(with: passwordString) {
            vm.passwordString = passwordString
            vm.isPasswordValid = true
        }
        else if isEndEditing {
            vm.isPasswordValid = false
            view.showErrorWithString("Неверный пароль")
        }
        else {
            vm.isPasswordValid = false
        }
        checkLoginButton()
    }
    
    // Проверка статуса кнопки "Войти"
    func checkLoginButton() {
        if vm.isEmailValid && vm.isPasswordValid {
            view.continueButtonEnabled(true)
        }
        else {
            view.continueButtonEnabled(false)
        }
    }
}
