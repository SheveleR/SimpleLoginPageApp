//
//  SLPLoginPageVC.swift
//  SimpleLoginPage
//
//  Created by SheveleR on 15/03/2018.
//  Copyright © 2018 SheveleR. All rights reserved.
//

import Foundation
import UIKit

class SLPLoginPageVC: UIViewController, UITextFieldDelegate, LoginPageVCProtocol {
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    private var isViewDisappearing: Bool = false
    let kColorWarmGrey: String = "#797979"
    let kColorOrangeButton: String = "#ff9b00"
    var loginPagePresenter: LoginPagePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBack()
        initUI()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    
    // При нажатии кнопки Назад ставим флаг для корректного закрытия при фокусе в textField
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isViewDisappearing = true
        removeKeyboardObservers()
    }
    
    // Инициализируем презентер
    func initBack() {
        loginPagePresenter = SLPLoginPagePresenter.init(self, SLPLoginPageModel(), SLPLoginPageVM())
    }
    
    // Инициализация UI
    func initUI() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailLabel.textColor = hexStringToUIColor(hex: kColorWarmGrey)
        passwordLabel.textColor = hexStringToUIColor(hex: kColorWarmGrey)
        loginButton.backgroundColor = hexStringToUIColor(hex: kColorWarmGrey)
        addKeyboardObservers()
        self.navigationController?.navigationBar.barTintColor = .white
    }
    
    // Нажатие кнопки "Забыли пароль"
    @IBAction func forgetPasswordButtonTapped(_ sender: UIButton) {
        loginPagePresenter.forgetPasswordTapped()
    }
    
    // Нажатие кнопки "Войти"
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        loginPagePresenter.loginTapped(emailTextField.text!, passwordTextField.text!)
    }
    
    // Нажатие кнопки "Создать аккаунт"
    @IBAction func createAccountButtonTapped(_ sender: UIButton) {
        loginPagePresenter.createAccountTapped()
    }
    
    // Обработка нажатия "Ввод" на клавиатуре
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField === emailTextField, let email = textField.text, !email.isEmpty, !isViewDisappearing {
            loginPagePresenter.isValidEmail(email, true)
        }
        else if textField === passwordTextField, let password = textField.text, !password.isEmpty, !isViewDisappearing {
            loginPagePresenter.isPasswordValid(password, true)
        }
    }
    
    // Обработка вводимых символов для смены стейта кнопки "Войти"
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
        if textField === emailTextField && !newString.isEmpty {
            loginPagePresenter.isValidEmail(newString, false)
        }
        else if textField === passwordTextField && !newString.isEmpty {
            loginPagePresenter.isPasswordValid(newString, false)
        }
        return true	
    }
    
    // По нажатию "Ввод" хайдим клавиатуру
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true;
    }
    
    // Показываем ошибку-алерт
    func showErrorWithString(_ errorMsg: String) {
        self.view.endEditing(true)
        let alert = UIAlertController(title: "Ошибка", message: errorMsg, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction.init(title: "Далее", style: .default, handler: { (action) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // Показываем сообщение о погоде
    func showWeatherAlert(_ weatherObject: WeatherObject) {
        view.endEditing(true)
        let alert = UIAlertController(title: "Текущая погода", message: "Город = Пенза, \n \(weatherObject.temperature!),\n \(weatherObject.windSpeed!)", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction.init(title: "ОК", style: .default, handler: { (action) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // Показываем клавиатуру + получаем возможность скроллить
    @objc func keyboardWillShow(notification:NSNotification){
        guard let keyboardFrameValue = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue else { return }
        let keyboardFrame = view.convert(keyboardFrameValue.cgRectValue, from: nil)
        scrollView.contentInset.bottom = keyboardFrame.size.height
        scrollView.scrollIndicatorInsets = scrollView.contentInset
        scrollView.scrollRectToVisible(createAccountButton.frame, animated: true)
    }
    
    // Хайдим клавиатуру
    @objc func keyboardWillHide(notification:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    // Добавление keyboardObservers
    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // Удаляем keyboardObservers
    func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }
    
    // Меняем состояние+цвет кнопки "Войти"
    func continueButtonEnabled(_ isEnabled: Bool) {
        if isEnabled {
            if #available(iOS 11.0, *) {
                loginButton.backgroundColor = UIColor.init(named: "loginPageOrangeButton")
            } else {
                loginButton.backgroundColor = hexStringToUIColor(hex: kColorOrangeButton)
            }
            loginButton.isUserInteractionEnabled = true
        }
        else {
            if #available(iOS 11.0, *) {
                loginButton.backgroundColor = UIColor.init(named: "loginPageWarmGrey")
            } else {
                loginButton.backgroundColor = hexStringToUIColor(hex: kColorWarmGrey)
            }
            loginButton.isUserInteractionEnabled = false
        }
    }
    
    // В iOS < 11 не можем использовать UIColor.init(named:), поэтому получаем цвет по hex 
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
