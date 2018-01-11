//
//  SelectedCitiesViewObserverProtocol.swift
//  WeatherForecaster
//
//  Created by Anton on 20.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation
protocol SelectedCitiesViewObserver {
    var view: SelectedCitiesViewObservable? {get set}
    func getListOfSelectedCities() -> [City]
    func updateWeatherForecast() -> Void
    func needToDelete(_ city: City) -> Void
    func fillSelectedCitiesWithSavedForecast() -> Void
}
