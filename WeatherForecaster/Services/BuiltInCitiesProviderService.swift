//
//  BuiltInCitiesProviderService.swift
//  WeatherForecaster
//
//  Created by Anton on 21.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation
class BuiltInCitiesProviderService: BuiltInCitiesProvider {    
    var persistentDataProvider: PersistentDataProvider?
    var builtInCitiesSourceProvider: BuiltInCitiesSourceProvider?
    
    func buildInCities() {
        let cities = builtInCitiesSourceProvider?.getCitiesFromSource()
        guard cities != nil, cities!.count > 0 else { return }
        saveBuiltInCitiesToPersistentStore(cities!)
        UserDefaults.standard.set(true, forKey: Keys.USERDEFAULTS_CITIES_WERE_BUILT_IN_KEY)
    }
    init(persistentDataProvider: PersistentDataProvider, builtInCitiesSourceProvider: BuiltInCitiesSourceProvider) {
        self.persistentDataProvider = persistentDataProvider
        self.builtInCitiesSourceProvider = builtInCitiesSourceProvider
    }
    
}
extension BuiltInCitiesProviderService {
    private func saveBuiltInCitiesToPersistentStore(_ cities: [City]) -> Void {
        for curCity in cities {
            persistentDataProvider?.save(curCity)
        }
    }
}



