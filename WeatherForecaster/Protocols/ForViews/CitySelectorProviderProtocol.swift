//
//  CitySelectorProviderProtocol.swift
//  WeatherForecaster
//
//  Created by Anton on 20.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation
import UIKit

protocol CitySelectorProvider {
    var presenter: SelectorCityObserver {get set}
    var presenterController: UITableViewController {get set}
    func selectCity() -> Void
    func wasSelected(city: City) -> Void
}
