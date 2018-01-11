//
//  BuiltInCitiesCSVSourceProvider.swift
//  WeatherForecaster
//
//  Created by Anton on 21.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation
import CSV
class BuiltInCitiesCSVSourceProvider: BuiltInCitiesSourceProvider {
    func getCitiesFromSource() -> [City] {
        var result = [City]()
        
        let filePath = getPathToFile()
        guard filePath != nil else {return result}
        
        let stream = InputStream(fileAtPath: filePath!)
        guard stream != nil else {return result}
        
        let csv = try! CSVReader(stream: stream!, hasHeaderRow: true)
        while csv.next() != nil {
            let city = makeCity(from: csv)
            guard city != nil else {continue}
            result.append(city!)
        }
        return result
    }
}

extension BuiltInCitiesCSVSourceProvider {
    
    private func getPathToFile() -> String? {
        return Bundle.main.path(forResource: Keys.ForBuiltInCitiesCSVSource.BUILT_IN_CITIES_FILE_NAME, ofType: Keys.ForBuiltInCitiesCSVSource.BUILT_IN_CITIES_FILE_TYPE)
    }
    
    private func makeCity(from csv: CSVReader) -> City? {
        if let name = csv[Keys.ForBuiltInCitiesCSVSource.PROPERTY_NAME_NAME],
            let country = csv[Keys.ForBuiltInCitiesCSVSource.PROPERTY_COUNTRY_NAME],
            let isocountrycode = csv[Keys.ForBuiltInCitiesCSVSource.PROPERTY_ISOCOUNTRYCODE_NAME],
            let latitude = csv[Keys.ForBuiltInCitiesCSVSource.PROPERTY_LATITUDE_NAME],
            let doubleLatitude = Double(latitude),
            let longitude = csv[Keys.ForBuiltInCitiesCSVSource.PROPERTY_LONGITUDE_NAME],
            let doubleLongitude = Double(longitude)
        {
            let city = City(name: name,
                            country: country ,
                            ISOCountryCode: isocountrycode,
                            latitude: doubleLatitude,
                            longitude: doubleLongitude)
            return city
        }
        return nil
    }
}

extension Keys {
    struct ForBuiltInCitiesCSVSource {
    static let BUILT_IN_CITIES_FILE_NAME: String = "builtInCitiesList"
    static let BUILT_IN_CITIES_FILE_TYPE: String = ".csv"
    
    static let PROPERTY_NAME_NAME: String = "name"
    static let PROPERTY_COUNTRY_NAME: String = "country"
    static let PROPERTY_ISOCOUNTRYCODE_NAME: String = "isocountrycode"
    static let PROPERTY_LATITUDE_NAME: String = "latitude"
    static let PROPERTY_LONGITUDE_NAME: String = "longitude"
    }
}
