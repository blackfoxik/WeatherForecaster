//
//  WeatherForecast + WeatherForecastPropertiesAsStringProvider.swift
//  WeatherForecaster
//
//  Created by Anton on 26.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation

extension WeatherForecast: WeatherForecastPropertiesAsStringProvider {
    func getShortWeatherDescription() -> String {
        return self.conditionals.icon
    }
    
    func getDateAsDayOfTheWeekString() -> String {
        return getStringDate(from: self.date)
    }
    
    func getCurTemperatureAsString() -> String {
        return getTemperatureStringRepresentation(of: self.conditionals.curTemperature)
    }
    
    func getMinTemperatureAsString() -> String {
        return getTemperatureStringRepresentation(of: self.conditionals.minTemperature)
    }
    
    func getMaxTemperatureAsString() -> String {
        return getTemperatureStringRepresentation(of: self.conditionals.maxTemperature)
    }
    
    func getHumidityAsString() -> String {
        return getHumidityStringRepresentation(of: self.conditionals.humidity)
    }
    
    func getWindSpeedAsString() -> String {
        return getWindSpeedStringRepresentation(of: self.conditionals.windSpeed)
    }
    
    func getPressureAsString() -> String {
        return getPressureStringRepresentation(of: self.conditionals.pressure)
    }
}

extension WeatherForecast {
    //TO DO
    //1 need to find more elegant way
    //2 functions should return result depends on conditional units
    private func getTemperatureStringRepresentation(of temperature: Double?) -> String {
        guard temperature != nil else { return Keys.PLACEHOLDERS.PLACEHOLDER_TEMPERATURE }
        return "\(getRoundedConvertedToIntAsString(temperature!))\(Keys.PLACEHOLDERS.TEMPERATURE_SIGN)"
    }
    
    private func getHumidityStringRepresentation(of humidity: Int?) -> String {
        guard humidity != nil else { return Keys.PLACEHOLDERS.PLACEHOLDER_HUMIDITI }
        return "\(humidity!) \(Keys.PLACEHOLDERS.HUMIDITI_SIGN)"
    }
    
    private func getWindSpeedStringRepresentation(of windSpeed: Double?) -> String {
        guard windSpeed != nil else { return Keys.PLACEHOLDERS.PLACEHOLDER_WINDSPEED }
        return "\(getRoundedConvertedToIntAsString(windSpeed!)) \(Keys.PLACEHOLDERS.WINDSPEED_SIGN)"
    }
    
    private func getPressureStringRepresentation(of pressure: Double?) -> String {
        guard pressure != nil else { return Keys.PLACEHOLDERS.PLACEHOLDER_PRESSURE }
        return "\(getRoundedConvertedToIntAsString(pressure!)) \(Keys.PLACEHOLDERS.PRESSURE_SIGN)"
    }
    
    private func getRoundedConvertedToIntAsString(_ value: Double) -> String {
        let roundedValue = round(value)
        let intValue = Int(roundedValue)
        return "\(intValue)"
    }
    
    private func getStringDate(from date: Date?) -> String {
        guard date != nil else { return Keys.PLACEHOLDERS.PLACEHOLDER_DATE }
        let formatter = DateFormatter()
        formatter.dateFormat =  Keys.DATE_FORMAT
        let stringDate = formatter.string(from: date!)
        return stringDate
    }
}

extension Keys {
    static let DATE_FORMAT: String = "EEEE d"
}

