//
//  ReachabilityCheckerProtocol.swift
//  WeatherForecaster
//
//  Created by Anton on 26.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation
protocol ReachabilityChecker {
    var internetIsAvailable: Bool {get}
    func startWatching() -> Void
    func stopWatching() -> Void
}
