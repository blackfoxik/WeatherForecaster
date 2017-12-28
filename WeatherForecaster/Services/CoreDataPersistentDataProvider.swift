//
//  CoreDataPersistentDataProvider.swift
//  WeatherForecaster
//
//  Created by Anton on 18.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//
import UIKit
import Foundation
import CoreData

class CoreDataPersistentDataProvider: PersistentDataProvider {
    
    let container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func save(_ city: City) {
        saveToCoreData(city)
    }
    
    func getListOfSelectedCities() -> [City] {
        let cities = getCitiesFromCoreData()
        return cities
    }
    
    func getSavedForecastFor(_ city: City, completion: @escaping ([WeatherForecast]?) -> Void) {
        let coreDataWeatherForecasts = getWeatherForecastsFromCoreData(for: city)
        completion(coreDataWeatherForecasts)
    }
    
    func deleteOldForecasts() {
        deleteOldForecastFromCoreData()
    }
    
    func delete(_ city: City) {
        deleteFromCoreData(city)
    }
    
    func update(_ city: City) {
        updateCoreDataCity(whichCorrespondsTo: city)
    }
}

//CRUD

//Create
extension CoreDataPersistentDataProvider {
    private func saveToCoreData(_ city: City) {
        let coreDataCity = CityTranslator.makeCoreDataCity(whichCorrespondsTo: city, in: context)
        //save forecasts to CoreData
        if city.forecasts != nil {
            for curWeatherForecast in city.forecasts! {
                let curCoreDataWeatherForecast = WeatherForecastTranslator.makeCoreDataWeatherForecast(whichCorrespondsTo: curWeatherForecast, in: context)
                curCoreDataWeatherForecast.city = coreDataCity
            }
        }
        saveContext()
    }
}

//Read
extension CoreDataPersistentDataProvider {
    private func getCitiesFromCoreData() -> [City] {
        var result = [City]()
        let citiesRequest: NSFetchRequest<CDCity> = CDCity.fetchRequest()
        do {
            let citiesMatches = try context!.fetch(citiesRequest)
            if citiesMatches.count > 0 {
                for curCoreDataCity in citiesMatches {
                    let curCity = CityTranslator.makeCity(from: curCoreDataCity)
                    result.append(curCity)
                }
            }
        } catch {
            //throw error
        }
        return result
    }
    
    private func getCoreDataCity(whichCorrespondsTo city: City) -> CDCity? {
        //let context = container?.viewContext
        let citiesRequest: NSFetchRequest<CDCity> = CDCity.fetchRequest()
        let predicateName = NSPredicate(format: "\(Keys.CORE_DATA.NAME_ATTRIBUTE_NAME) = %@", city.name)
        let predicateCountry = NSPredicate(format: "\(Keys.CORE_DATA.COUNTRY_ATTRIBUTE_NAME) = %@", city.country)
        let predicateLatitude = NSPredicate(format: "\(Keys.CORE_DATA.LATITUDE_ATTRIBUTE_NAME) == %lf", city.latitude)
        let predicateLongitude = NSPredicate(format: "\(Keys.CORE_DATA.LONGITUDE_ATTRIBUTE_NAME) == %lf", city.longitude)
        citiesRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicateName,
                                                                                      predicateCountry,
                                                                                      predicateLatitude,
                                                                                      predicateLongitude])
        do {
            let citiesMatches = try context!.fetch(citiesRequest)
            if citiesMatches.count > 0 {
                return citiesMatches[0]
            }
        } catch {
            //throw error
        }
        return nil
    }
    
    private func getCoreDataWeatherForecast(whichCorrespondsTo weatherForecast: WeatherForecast) -> CDWeatherForecast? {
        
        let weatherForecastRequest: NSFetchRequest<CDWeatherForecast> = CDWeatherForecast.fetchRequest()
        let coreDataCity = getCoreDataCity(whichCorrespondsTo: weatherForecast.city)
        guard coreDataCity != nil else { return nil }
        let predicateCity = NSPredicate(format: "\(Keys.CORE_DATA.CITY_ATTRIBUTE_NAME) = %@", coreDataCity!)
        let predicateDate = NSPredicate(format: "\(Keys.CORE_DATA.DATE_ATTRIBUTE_NAME) = %@", weatherForecast.date as NSDate)
        weatherForecastRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicateCity, predicateDate])
        do {
            let weatherForecastMatches = try context!.fetch(weatherForecastRequest)
            if weatherForecastMatches.count > 0 {
                return weatherForecastMatches[0]
            }
        } catch {
            //throw error
        }
        return nil
    }
    
    private func getCoreDataCurrentWeatherForecast(whichCorrespondsTo weatherForecast: WeatherForecast) -> CDWeatherForecast? {
        
        let weatherForecastRequest: NSFetchRequest<CDWeatherForecast> = CDWeatherForecast.fetchRequest()
        let coreDataCity = getCoreDataCity(whichCorrespondsTo: weatherForecast.city)
        guard coreDataCity != nil else { return nil }
        let predicateCity = NSPredicate(format: "\(Keys.CORE_DATA.CITY_ATTRIBUTE_NAME) = %@", coreDataCity!)
        let predicateIsCurrent = NSPredicate(format: "\(Keys.CORE_DATA.IS_CURRENT_WEATHER_ATTRIBUTE_NAME) = true")
        weatherForecastRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicateCity, predicateIsCurrent])
        do {
            let weatherForecastMatches = try context!.fetch(weatherForecastRequest)
            if weatherForecastMatches.count > 0 {
                return weatherForecastMatches[0]
            }
        } catch {
            //throw error
        }
        return nil
    }
    
    private func getWeatherForecastsFromCoreData(for city: City) -> [WeatherForecast]? {
        //get all forecast for city
        let curCoreDataCity = getCoreDataCity(whichCorrespondsTo: city)
        if curCoreDataCity != nil {
            let weatherForecastRequest: NSFetchRequest<CDWeatherForecast> = CDWeatherForecast.fetchRequest()
            weatherForecastRequest.predicate = NSPredicate(format: "\(Keys.CORE_DATA.CITY_ATTRIBUTE_NAME) = %@", curCoreDataCity!)
            do {
                let weatherForecastMatches = try context!.fetch(weatherForecastRequest)
                if weatherForecastMatches.count > 0 {
                    var forecasts = [WeatherForecast]()
                    for curCoreDataWeatherForecast in weatherForecastMatches {
                        let weatherForecast = WeatherForecastTranslator.makeWeatherForecast(from: curCoreDataWeatherForecast, for: city)
                        forecasts.append(weatherForecast)
                    }
                    return forecasts
                }
            } catch {
                //throw error
            }
        }
        return nil
    }
}

//Update
extension CoreDataPersistentDataProvider {
    private func updateCoreDataCity(whichCorrespondsTo city: City) -> Void {
        let coreDataCity = getCoreDataCity(whichCorrespondsTo: city)
        guard coreDataCity != nil, city.forecasts != nil, city.forecasts!.count > 0 else {return}
        
                for curForecast in city.forecasts! {
                    var curCoreDataWeatherForecast: CDWeatherForecast?
                    
                    if curForecast.isCurrentWeather {
                        curCoreDataWeatherForecast = getCoreDataCurrentWeatherForecast(whichCorrespondsTo: curForecast)
                    } else {
                        curCoreDataWeatherForecast = getCoreDataWeatherForecast(whichCorrespondsTo: curForecast)
                    }
                    
                    if curCoreDataWeatherForecast != nil {
                        update(curCoreDataWeatherForecast! , with: curForecast)
                    } else {
                        curCoreDataWeatherForecast = WeatherForecastTranslator.makeCoreDataWeatherForecast(whichCorrespondsTo: curForecast, in: context)
                    }
                    curCoreDataWeatherForecast?.city = coreDataCity
                }
            saveContext()
    }
    
    private func update(_ coreDataWeatherForecast: CDWeatherForecast, with weatherForecast: WeatherForecast) {
        if weatherForecast.conditionals.curTemperature != nil {
            coreDataWeatherForecast.curTemperature = weatherForecast.conditionals.curTemperature!
        }
        if weatherForecast.conditionals.minTemperature != nil {
            coreDataWeatherForecast.minTemperature = weatherForecast.conditionals.minTemperature!
        }
        if weatherForecast.conditionals.maxTemperature != nil {
            coreDataWeatherForecast.maxTemperature = weatherForecast.conditionals.maxTemperature!
        }
        if weatherForecast.isCurrentWeather {
            coreDataWeatherForecast.date = weatherForecast.date
        }
        coreDataWeatherForecast.humidity = Int32(weatherForecast.conditionals.humidity)
        coreDataWeatherForecast.pressure = weatherForecast.conditionals.pressure
        coreDataWeatherForecast.windSpeed = weatherForecast.conditionals.windSpeed
        coreDataWeatherForecast.icon = weatherForecast.conditionals.icon
    }
}

//Delete
extension CoreDataPersistentDataProvider {
    private func deleteFromCoreData(_ city: City) {
        let coreDataCity = getCoreDataCity(whichCorrespondsTo: city)
        if coreDataCity != nil {
            context?.delete(coreDataCity!)
        }
        saveContext()
    }
    
    private func deleteOldForecastFromCoreData() -> Void {
        let weatherForecastRequest: NSFetchRequest<CDWeatherForecast> = CDWeatherForecast.fetchRequest()
        let today =  Date().endOfDay!
        let predicateDate = NSPredicate(format: "\(Keys.CORE_DATA.DATE_ATTRIBUTE_NAME) <= %@", today as NSDate)
        weatherForecastRequest.predicate = predicateDate
        do {
            let weatherForecastMatches = try context!.fetch(weatherForecastRequest)
            if weatherForecastMatches.count > 0 {
                for curWeatherForecast in weatherForecastMatches {
                    if curWeatherForecast.isCurrentWeather && curWeatherForecast.date!.isDateInToday { continue }
                    context?.delete(curWeatherForecast)
                }
                saveContext()
            }
        } catch {
            //throw error
        }
    }
}

//Supporting
extension CoreDataPersistentDataProvider {
    private func saveContext() {
        do {
            try context?.save()
        } catch let error as NSError {
            print("Could not make a saving. \(error), \(error.userInfo)")
        }
    }
}

extension Keys {
    struct CORE_DATA {
        static let CITY_ENTITY_NAME: String = "City"
        static let WEATHER_FORECAST_ENTITY_NAME: String = "WeatherForecast"
        static let NAME_ATTRIBUTE_NAME: String = "name"
        static let CITY_ATTRIBUTE_NAME: String = "city"
        static let COUNTRY_ATTRIBUTE_NAME: String = "country"
        static let LATITUDE_ATTRIBUTE_NAME: String = "latitude"
        static let LONGITUDE_ATTRIBUTE_NAME: String = "longitude"
        static let IS_CURRENT_WEATHER_ATTRIBUTE_NAME: String = "isCurrentWeather"
        static let DATE_ATTRIBUTE_NAME: String = "date"
    }
}

extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date? {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)
    }
    
    var isDateInToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
}



