//
//  Forecast.swift
//  WeatherForecaster
//
//  Created by Anton on 16.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation

class WeatherForecast {
    let city: City
    let date: Date
    var isCurrentWeather: Bool
    var conditionals: Conditional
    
    init(city: City, date: Date, conditionals: Conditional, isCurrentWeather: Bool = false) {
        self.city = city
        self.date = date
        self.conditionals = conditionals
        self.isCurrentWeather = isCurrentWeather
    }
    
    struct Conditional {
        var curTemperature: Double?
        var minTemperature: Double?
        var maxTemperature: Double?
        var humidity: Int
        var windSpeed: Double
        var pressure: Double
        var icon: String
    }
}

