//
//  City + CityForSelectedCitiesTableView.swift
//  WeatherForecaster
//
//  Created by Anton on 26.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation
typealias CityForSelectedCitiesTableView = (cityName: String, currentTemperature: String)

extension City: CityForSelectedCitiesTableViewProvider {
    var cityForSelectedCitiesTableView: CityForSelectedCitiesTableView {
        guard self.currentWeather != nil,
              self.currentWeather?.conditionals.curTemperature != nil else {return (self.name, Keys.PLACEHOLDERS.PLACEHOLDER_TEMPERATURE)}
        return (self.name, (self.currentWeather?.getCurTemperatureAsString())!)
    }
}


