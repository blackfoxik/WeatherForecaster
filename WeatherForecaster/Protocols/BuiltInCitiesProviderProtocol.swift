//
//  BuiltInCitiesProviderProtocol.swift
//  WeatherForecaster
//
//  Created by Anton on 21.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation

protocol BuiltInCitiesProvider {
    var persistentDataProvider: PersistentDataProvider? {get set}
    var builtInCitiesSourceProvider: BuiltInCitiesSourceProvider? {get set}
    func buildInCities() -> Void
}
