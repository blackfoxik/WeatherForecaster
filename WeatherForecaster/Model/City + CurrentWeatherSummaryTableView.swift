//
//  City + CurrentWeatherConditionalsForSummaryView.swift
//  WeatherForecaster
//
//  Created by Anton on 26.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation

typealias CurrentWeatherForSummaryView = [Int : (key: String, value: String)]

extension City: CurrentWeatherForSummaryViewProvider {
    func getCurrentWeatherForSummaryView() -> CurrentWeatherForSummaryView {
        var weatherConditionals = CurrentWeatherForSummaryView()
        weatherConditionals[0] = (Keys.PLACEHOLDERS.PRESSURE_TITLE, self.currentWeather?.getPressureAsString() ?? Keys.PLACEHOLDERS.PLACEHOLDER_PRESSURE)
        weatherConditionals[1] = (Keys.PLACEHOLDERS.HUMIDITY_TITLE, self.currentWeather?.getHumidityAsString() ?? Keys.PLACEHOLDERS.PLACEHOLDER_HUMIDITI)
        weatherConditionals[2] = (Keys.PLACEHOLDERS.WINDSPEED_TITLE, self.currentWeather?.getWindSpeedAsString() ?? Keys.PLACEHOLDERS.PLACEHOLDER_WINDSPEED)
        return weatherConditionals
    }
}



//unfortunatelly we still cannot make an extension for inner type in separate files so
//placeholders defined in main file


