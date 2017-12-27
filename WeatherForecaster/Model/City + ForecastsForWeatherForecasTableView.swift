//
//  City + ViewProtocols.swift
//  WeatherForecaster
//
//  Created by Anton on 26.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation
import UIKit

typealias ForecastForWeatherForecastTableView = (dayOfTheWeek: String, conditionalImage: UIImage?, maxTemperature: String, minTemperature: String)


extension City: ForecastsForWeatherForecasTableViewProvider {
    func getWeatherForecastsForView() -> [Int: ForecastForWeatherForecastTableView]? {
                                                    
            var weatherForecasts = self.forecasts
            guard weatherForecasts != nil, weatherForecasts!.count > 0 else { return nil }
            weatherForecasts?.sort{$0.date < $1.date}
            var resultWeatherForecasts = [Int: ForecastForWeatherForecastTableView]()
            var numberOfForecast: Int = 0
            for curForecast in weatherForecasts! {
                guard !curForecast.isCurrentWeather else { continue }
                let dayOfTheWeek = curForecast.getDateAsDayOfTheWeekString()
                let conditionalImage = curForecast.getImage()
                let maxTemp = curForecast.getMaxTemperatureAsString()
                let minTemp = curForecast.getMinTemperatureAsString()
                resultWeatherForecasts[numberOfForecast] = (dayOfTheWeek, conditionalImage, maxTemp, minTemp)
                numberOfForecast += 1
            }
            return resultWeatherForecasts
        }

}




