//
//  PersistentDataProviderProtocol.swift
//  WeatherForecaster
//
//  Created by Anton on 20.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation
protocol PersistentDataProvider {
    func getListOfSelectedCities() -> [City]
    func getSavedForecastFor(_ city: City, completion: @escaping ([WeatherForecast]?) -> Void) -> Void
    func delete(_ city: City) -> Void
    func update(_ city: City) -> Void
    func save(_ city: City) -> Void
    func deleteOldForecasts() -> Void
}
