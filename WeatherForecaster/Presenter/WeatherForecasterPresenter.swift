//
//  WeatherForecasterPresenter.swift
//  WeatherForecaster
//
//  Created by Anton on 16.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation

class WeatherForecasterPresenter {
    
    let forecastProvider: ForecastProvider
    let persistentDataProvider: PersistentDataProvider
    var view: SelectedCitiesViewObservable?
    var listOfSelectedCities = [City]()
    
    init(forecastProvider: ForecastProvider, persistentDataProvider: PersistentDataProvider) {
        self.forecastProvider = forecastProvider
        self.persistentDataProvider = persistentDataProvider
    }
}

extension WeatherForecasterPresenter: SelectorCityObserver {
    func wasSelected(city: City) {        
        let theSameCityWasSelectedBefore = wasSelectedBefore(city)
        guard theSameCityWasSelectedBefore == false else {return}
        self.listOfSelectedCities.append(city)
        self.persistentDataProvider.save(city)
        view?.wasAdded(city)
        getForecastFor(city)
    }
}

extension WeatherForecasterPresenter: SelectedCitiesViewObserver {
    func getListOfSelectedCities() -> [City] {
        listOfSelectedCities = persistentDataProvider.getListOfSelectedCities()
        return listOfSelectedCities
    }
        
    func fillSelectedCitiesWithSavedForecast() -> Void {
        persistentDataProvider.deleteOldForecasts()
        if forecastProvider.isLastWeatherForecastUpdatingActual {
            for curCity in listOfSelectedCities {
                self.persistentDataProvider.getSavedForecastFor(curCity) { savedForecasts in
                    guard savedForecasts != nil else {return}
                    curCity.forecasts = savedForecasts
                    self.view?.wasUpdated(curCity)
                }
                
            }
        }
    }
    
    func updateWeatherForecast() {
        persistentDataProvider.deleteOldForecasts()
        for curCity in listOfSelectedCities {
            getForecastFor(curCity)
        }
    }
    
    func needToDelete(_ city: City) {
        persistentDataProvider.delete(city)
    }
}


extension WeatherForecasterPresenter {
    private func getForecastFor(_ city: City) -> Void {
        forecastProvider.getForecastsFor(city) { weatherForecasts, error in
            if error == nil, weatherForecasts != nil, weatherForecasts!.count > 0 {
                city.forecasts = weatherForecasts
                self.persistentDataProvider.update(city)
                self.view?.wasUpdated(city)
            } else {
                //view?.wasOccured(error)
            }
        }
    }
}

//supporting functions
extension WeatherForecasterPresenter {
    private func wasSelectedBefore(_ city: City) -> Bool {
        let indexOfTheSameCity = listOfSelectedCities.index{$0 == city}
        if indexOfTheSameCity == nil {
            return false
        }
        return true
    }
}











