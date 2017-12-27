//
//  City + CurrentWeatherForMainInfoView.swift
//  WeatherForecaster
//
//  Created by Anton on 26.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation
typealias CurrentWeatherForMainInfoView = (currentTemperature: String, shortDescription: String)

extension City: CurrentWeatherForMainInfoViewProvider {
    var currentWeatherForMainInfoView: CurrentWeatherForMainInfoView {
        guard self.hasCurWeather()  else {return self.getStubCurrentWeatherForMainInfoView()}
        return self.getCurrentWeatherForMainInfoView()
    }
}

extension City {
    fileprivate func hasCurWeather() -> Bool {
        guard self.currentWeather != nil,
            self.currentWeather?.conditionals.curTemperature != nil  else {return false}
        return true
    }
    
    fileprivate func getStubCurrentWeatherForMainInfoView() -> CurrentWeatherForMainInfoView {
        let stub = (Keys.PLACEHOLDERS.PLACEHOLDER_TEMPERATURE, Keys.PLACEHOLDERS.PLACEHOLDER_SHORT_WEATHER_DESCRIPTION)

        return stub
    }
    
    fileprivate func getCurrentWeatherForMainInfoView() -> CurrentWeatherForMainInfoView {
        return (self.currentWeather!.getCurTemperatureAsString(), self.currentWeather!.getShortWeatherDescription())
    }
}


