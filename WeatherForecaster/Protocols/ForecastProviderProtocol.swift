//
//  ForecastProviderProtocol.swift
//  WeatherForecaster
//
//  Created by Anton on 20.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation
protocol ForecastProvider {
    var isLastWeatherForecastUpdatingActual: Bool {get}
    func getForecastsFor(_ city: City, completion: @escaping([WeatherForecast]?, Error?) -> Void ) -> Void
    func getDateOfLastForecastUpdating() -> Date?
}
