//
//  UserChangedCountOfDaysForecastHandlerProtocol.swift
//  WeatherForecaster
//
//  Created by Anton on 27.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation
protocol UserChangedCountOfDaysForecastHandler {
    func userChangedCountOfDaysForecast(to variant: DaysForShowingVariant)
}
