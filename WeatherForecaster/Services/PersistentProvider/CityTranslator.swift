//
//  CityTranslator.swift
//  WeatherForecaster
//
//  Created by Anton on 27.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation
import CoreData

class CityTranslator {
    //from CDCity to City
    static func makeCity(from curCoreDataCity: CDCity) -> City {
        let city = City(name: curCoreDataCity.name!,
                        country: curCoreDataCity.country!,
                        ISOCountryCode: curCoreDataCity.iSOCountryCode!,
                        latitude: curCoreDataCity.latitude,
                        longitude: curCoreDataCity.longitude)
        return city
    }
    
    //From City to CDCity
    static func makeCoreDataCity(whichCorrespondsTo city: City, in context: NSManagedObjectContext?) -> CDCity {
        let entityDescription = NSEntityDescription.entity(forEntityName: Keys.CORE_DATA.CITY_ENTITY_NAME, in: context!)
        
        let coreDataCity = CDCity(entity: entityDescription!, insertInto: context)
        coreDataCity.name = city.name
        coreDataCity.country = city.country
        coreDataCity.iSOCountryCode = city.ISOCountryCode
        coreDataCity.latitude = city.latitude
        coreDataCity.longitude = city.longitude
        
        return coreDataCity
    }
}
