//
//  SLPLoginPageModel.swift
//  SimpleLoginPage
//
//  Created by SheveleR on 15/03/2018.
//  Copyright © 2018 SheveleR. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SLPLoginPageModel: LoginPageModelProtocol {
    let url: URL! = URL.init(string: "https://api.openweathermap.org/data/2.5/weather?q=Penza,ru&appid=ccf97d9c3acf2f9491f0342a964633e3&units=metric") // Дефолтный url для погоды города Пенза
    
    // Запрос к api Weather
    func fakeLoginRequest(_ email: String, password: String, _ callback: ((WeatherObject?, SimpleCustomError?)->Void)?) {
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default).responseJSON { (dataResponse) in
            if let dataResp = dataResponse.result.value {
                let swiftyJsonVar = JSON(dataResp)
                let weatherObject = self.prepareWeatherObject(swiftyJsonVar)
                if let obj = weatherObject {
                    callback!(obj, nil)
                }
        
            }
            else if let error = dataResponse.error {
                callback!(nil, SimpleCustomError(withErrorLocalizedString: error.localizedDescription))
            }
        }
    }
    
    // Подготавливаем объект WeatherObject
    func prepareWeatherObject(_ json: JSON) -> WeatherObject? {
        if !json["main"]["temp"].stringValue.isEmpty && !json["wind"]["speed"].stringValue.isEmpty  {
            let temperature = "\(json["main"]["temp"].stringValue)"
            let windSpeed = "\(json["wind"]["speed"].stringValue)"
            return WeatherObject(temperature, windSpeed)
        }
        return nil
    }
    
}
