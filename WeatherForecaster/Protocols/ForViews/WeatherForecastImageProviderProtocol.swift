//
//  WeatherForecastImageProviderProtocol.swift
//  WeatherForecaster
//
//  Created by Anton on 26.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation
import UIKit

protocol WeatherForecastImageProvider {
    func getImage() -> UIImage?
}
