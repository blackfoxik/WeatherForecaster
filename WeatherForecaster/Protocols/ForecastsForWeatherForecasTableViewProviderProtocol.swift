//
//  ForecastsForWeatherForecasTableViewProviderProtocol.swift
//  WeatherForecaster
//
//  Created by Anton on 26.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation
protocol ForecastsForWeatherForecasTableViewProvider {
    func getWeatherForecastsForView() -> [Int: ForecastForWeatherForecastTableView]?
}
