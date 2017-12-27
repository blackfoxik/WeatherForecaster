//
//  DarkSkyForecastProvider.swift
//  WeatherForecaster
//
//  Created by Anton on 17.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation
import SwiftSky


class DarkSkyForecastProvider {
    init () {
        SwiftSky.secret = Keys.ForecastProvider.DARKSKY_API_KEY
        
        SwiftSky.units.temperature = .celsius
        SwiftSky.units.distance = .kilometer
        SwiftSky.units.speed = .meterPerSecond
        SwiftSky.units.pressure = .hectopascal
        SwiftSky.units.precipitation = .millimeter
        SwiftSky.units.accumulation = .centimeter
    }
}

extension DarkSkyForecastProvider: ForecastProvider {
    var isLastWeatherForecastUpdatingActual: Bool {
        get {
            return lastForecastUpdatingIsActual()
        }
    }
    
    func getDateOfLastForecastUpdating() -> Date? {
        return getDateOfLastForecastUpdatingFromUsersDefault()
    }
    
    func getForecastsFor(_ city: City, completion: @escaping ([WeatherForecast]?, Error?) -> Void)
    {
        getForecastsFromDarkSkyFor(city, completion: completion)
    }
    
}

extension DarkSkyForecastProvider {
    private func getForecastsFromDarkSkyFor(_ city: City, completion: @escaping ([WeatherForecast]?, Error?) -> Void ) {
        SwiftSky.get([.current, .days],
                     at: Location(latitude: city.latitude, longitude: city.longitude)
        ) { result in
            switch result {
            case .success(let forecast):
                let curWeather = self.getCurWeatherFrom(forecast, city: city)
                var forecasts = self.make(forecast: forecast, city: city)
                forecasts.append(curWeather)
                self.fixDateOfForecastUpdating()
                completion(forecasts, nil)
            case .failure(let error):
                completion(nil, error)
            }
            
        }
    }
    
    private func getCurWeatherFrom(_ forecast: Forecast, city: City) -> WeatherForecast {
        let curConditional = WeatherForecast.Conditional(curTemperature: forecast.current?.temperature?.current?.value,
                                                         minTemperature: nil,
                                                         maxTemperature: nil,
                                                         humidity: (forecast.current?.humidity?.value)!,
                                                         windSpeed: (forecast.current?.wind?.speed?.value)!,
                                                         pressure: (forecast.current?.pressure?.value)!,
                                                         icon: (forecast.current?.icon)!)
        let weather = WeatherForecast(city: city, date: (forecast.current?.time)!, conditionals: curConditional, isCurrentWeather: true)
        return weather
    }
    
    private func make(forecast: Forecast, city: City) -> [WeatherForecast] {
        var forecasts = [WeatherForecast]()
        for curDay in (forecast.days?.points)! {
            let curConditional = WeatherForecast.Conditional(curTemperature: nil,
                                                             minTemperature: curDay.temperature?.min?.value,
                                                             maxTemperature: curDay.temperature?.max?.value,
                                                             humidity: (curDay.humidity?.value)!,
                                                             windSpeed: (curDay.wind?.speed?.value)!,
                                                             pressure: (curDay.pressure?.value)!,
                                                             icon: curDay.icon!)
            
            let curForecast = WeatherForecast(city: city, date: curDay.time, conditionals: curConditional)
            forecasts.append(curForecast)
        }
        //crutch
        //DarkSky inserts current day as forecast
        forecasts.remove(at: 0)
        return forecasts
    }
}

extension DarkSkyForecastProvider {
    func getDateOfLastForecastUpdatingFromUsersDefault() -> Date? {
        let dateOfLastForecastUpdating = UserDefaults.standard.object(forKey: Keys.ForecastProvider.USERDEFAULTS_DATE_OF_LAST_UPDATING_FORECAST_KEY) as? Date
        return dateOfLastForecastUpdating
    }
    
    func fixDateOfForecastUpdating() -> Void {
        UserDefaults.standard.set(Date(), forKey: Keys.ForecastProvider.USERDEFAULTS_DATE_OF_LAST_UPDATING_FORECAST_KEY)
    }
}

extension DarkSkyForecastProvider {
    private func lastForecastUpdatingIsActual() -> Bool {
        let dateOfLastWeatherForecastUpdating = getDateOfLastForecastUpdating()
        guard dateOfLastWeatherForecastUpdating != nil else { return false }
        let countOfHoursSinceLastForecastUpdating = Date().hours(from: dateOfLastWeatherForecastUpdating!)
        if countOfHoursSinceLastForecastUpdating < Keys.ForecastProvider.COUNT_OF_HOURS_WHEN_LAST_FORECAST_UPDATING_IS_ACTUAL {
            return true
        } else {
            return false
        }
    }
}

extension Keys {
    struct ForecastProvider {
        static let DARKSKY_API_KEY: String = "d47acfc455c823d15a65674b00b2ccc8"
        static let USERDEFAULTS_DATE_OF_LAST_UPDATING_FORECAST_KEY: String = "dateOfLastUpdatingForecast"
        static let COUNT_OF_HOURS_WHEN_LAST_FORECAST_UPDATING_IS_ACTUAL: Int = 24
    }
}

extension Date {
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
}




