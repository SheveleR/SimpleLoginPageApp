//
//  WeatherObject.swift
//  SimpleLoginPage
//
//  Created by SheveleR on 16/03/2018.
//  Copyright © 2018 SheveleR. All rights reserved.
//

import Foundation

class WeatherObject {
    fileprivate var _temperature: String!
    fileprivate var _windSpeed: String!
    var temperature: String! {
        set(newValue) {
            _temperature =  "Текущая температура = \(newValue!)°C"
        }
        get {
            return _temperature
        }
    }
    var windSpeed: String! {
        set(newValue) {
            _windSpeed = "Скорость ветра = \(newValue!) м/с"
        }
        get {
            return _windSpeed
        }
    }
    
    init(_ temperature: String, _ windSpeed: String) {
        self.temperature = temperature
        self.windSpeed = windSpeed
    }
}
