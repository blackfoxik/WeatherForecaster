//
//  WeatherForecastPropertiesAsStringProviderProtocol.swift
//  WeatherForecaster
//
//  Created by Anton on 26.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation
protocol WeatherForecastPropertiesAsStringProvider {
    func getDateAsDayOfTheWeekString() -> String
    func getCurTemperatureAsString() -> String
    func getMinTemperatureAsString() -> String
    func getMaxTemperatureAsString() -> String
    func getHumidityAsString() -> String
    func getWindSpeedAsString() -> String
    func getPressureAsString() -> String
    func getShortWeatherDescription() -> String
}
