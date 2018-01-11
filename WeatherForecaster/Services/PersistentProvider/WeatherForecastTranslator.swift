//
//  WeatherForecastTranslator.swift
//  WeatherForecaster
//
//  Created by Anton on 27.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation
import CoreData

class WeatherForecastTranslator {
    
    //from CDWeatherForecast to WeatherForecast
    static func makeWeatherForecast(from coreDataWeatherForecast: CDWeatherForecast, for city: City) -> WeatherForecast {
        let conditionals = makeWeatherForecastConditional(from: coreDataWeatherForecast)
        
        let weatherForecast = WeatherForecast(city: city, date: coreDataWeatherForecast.date!, conditionals: conditionals, isCurrentWeather: coreDataWeatherForecast.isCurrentWeather)
        return weatherForecast
    }
    
    static func makeWeatherForecastConditional(from coreDataWeatherForecast: CDWeatherForecast) -> WeatherForecast.Conditional {
        let conditionals = WeatherForecast.Conditional(curTemperature: coreDataWeatherForecast.curTemperature,
                                                       minTemperature: coreDataWeatherForecast.minTemperature,
                                                       maxTemperature: coreDataWeatherForecast.maxTemperature,
                                                       humidity: Int(coreDataWeatherForecast.humidity),
                                                       windSpeed: coreDataWeatherForecast.windSpeed,
                                                       pressure: coreDataWeatherForecast.pressure,
                                                       icon: coreDataWeatherForecast.icon!)
        return conditionals
    }
    
    //From WeatherForecast to CDWeatherForecast
    static func makeCoreDataWeatherForecast(whichCorrespondsTo weatherForecast: WeatherForecast, in context: NSManagedObjectContext?) -> CDWeatherForecast {
        
        let weatherForecastDescription = NSEntityDescription.entity(forEntityName: Keys.CORE_DATA.WEATHER_FORECAST_ENTITY_NAME, in: context!)
        let coreDataWeatherForecast = CDWeatherForecast(entity: weatherForecastDescription!, insertInto: context)
        
        if weatherForecast.conditionals.curTemperature != nil {
            coreDataWeatherForecast.curTemperature = (weatherForecast.conditionals.curTemperature)!
        }
        
        if weatherForecast.conditionals.minTemperature != nil {
            coreDataWeatherForecast.minTemperature = (weatherForecast.conditionals.minTemperature)!
        }
        
        if weatherForecast.conditionals.maxTemperature != nil {
            coreDataWeatherForecast.maxTemperature = (weatherForecast.conditionals.maxTemperature)!
        }
        
        if weatherForecast.isCurrentWeather {
            coreDataWeatherForecast.isCurrentWeather = true
        }
        
        let hum = weatherForecast.conditionals.humidity
        coreDataWeatherForecast.humidity = Int32(hum)
        
        coreDataWeatherForecast.pressure = weatherForecast.conditionals.pressure
        coreDataWeatherForecast.windSpeed = weatherForecast.conditionals.windSpeed
        coreDataWeatherForecast.date = weatherForecast.date
        coreDataWeatherForecast.icon = weatherForecast.conditionals.icon
        return coreDataWeatherForecast
    }
}
