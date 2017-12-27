//
//  SelectorCityObserverProtocol.swift
//  WeatherForecaster
//
//  Created by Anton on 20.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation
protocol SelectorCityObserver {
    func wasSelected(city: City) -> Void
}
