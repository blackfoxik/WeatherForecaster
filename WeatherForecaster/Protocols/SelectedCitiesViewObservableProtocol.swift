//
//  SelectedCitiesViewObservableProtocol.swift
//  WeatherForecaster
//
//  Created by Anton on 20.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation
protocol SelectedCitiesViewObservable {
    func wasUpdated(_ city: City) -> Void
    func wasAdded(_ city: City) -> Void
}
