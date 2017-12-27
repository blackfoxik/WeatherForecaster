//
//  City.swift
//  WeatherForecaster
//
//  Created by Anton on 16.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation

class City {
    let name: String
    let country: String
    let ISOCountryCode: String
    let latitude: Double
    let longitude: Double
    var forecasts: [WeatherForecast]?
    var currentWeather: WeatherForecast? {
        get {
            guard self.forecasts != nil, self.forecasts!.count > 0 else {return nil}
            for curForecast in forecasts! {
                if curForecast.isCurrentWeather {return curForecast}
            }
            return nil
        }
    }
    
    init(name: String, country: String, ISOCountryCode: String, latitude: Double, longitude: Double) {
        self.name = name
        self.country = country
        self.ISOCountryCode = ISOCountryCode
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension City: Equatable {
    static func ==(lhs: City, rhs: City) -> Bool {
        if lhs.name == rhs.name &&
            lhs.country == rhs.country &&
            lhs.ISOCountryCode == rhs.ISOCountryCode &&
            lhs.longitude == rhs.longitude &&
            lhs.latitude == rhs.latitude {return true}
        return false
    }
}



