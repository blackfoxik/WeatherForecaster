//
//  GooglePlacesCitySelectorProvider.swift
//  WeatherForecaster
//
//  Created by Anton on 17.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation
import GooglePlacesSearchController

class GooglePlacesCitySelectorProvider: CitySelectorProvider {
     
    var presenter: SelectorCityObserver
    var presenterController: UITableViewController
    var selectingCityController: GooglePlacesSearchController!
    
    func selectCity() {
        presenterController.present(selectingCityController, animated: true, completion: nil)
    }
    
    func wasSelected(city: City) {
        presenter.wasSelected(city: city)
    }
    
    init(presenterController: UITableViewController, presenter: SelectorCityObserver) {
        self.presenterController = presenterController
        self.presenter = presenter
        self.selectingCityController = GooglePlacesSearchController(apiKey: Keys.GOOGLE_PLACES_API_KEY , placeType: PlaceType.cities)
        
        self.selectingCityController.didSelectGooglePlace { (place) -> Void in
            self.selectingCityController.isActive = false
            
            let city = self.makeCityFrom(detailsOf: place)
            self.wasSelected(city: city)
        }
    }
}

extension GooglePlacesCitySelectorProvider {
    private func makeCityFrom(detailsOf place: PlaceDetails) -> City {
        let city = City(name: place.name,
                        country: place.country,
                        ISOCountryCode: place.ISOcountryCode,
                        latitude: place.coordinate.latitude,
                        longitude: place.coordinate.longitude)
        return city
    }
}

extension Keys {
    static let GOOGLE_PLACES_API_KEY: String = "AIzaSyDfXy4I2evm8gjKbYcxEFyy5XZmbiS52fM"
}
