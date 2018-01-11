//
//  BuiltInCitiesSourceProviderProtocol.swift
//  WeatherForecaster
//
//  Created by Anton on 21.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation
protocol BuiltInCitiesSourceProvider {
    func getCitiesFromSource() -> [City]
}
