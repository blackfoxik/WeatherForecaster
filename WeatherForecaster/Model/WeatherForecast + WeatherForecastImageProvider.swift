//
//  WeatherForecast + ImageProtocol.swift
//  WeatherForecaster
//
//  Created by Anton on 24.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import Foundation
import UIKit

extension WeatherForecast: WeatherForecastImageProvider {
    func getImage() -> UIImage? {
        let imagesPaths = getImagesPaths()
        let imageName = imagesPaths[self.conditionals.icon]
        guard imageName != nil else { return nil}
        return UIImage(named: imageName!)
    }
}

extension WeatherForecast {
    private func getImagesPaths() -> [String: String] {
        let dictOfPathIcons: [String: String] = [
            Weather.clearDay.rawValue: "\(Weather.clearDay)\(Keys.IMAGE_TYPE)",
            Weather.clearNight.rawValue: "\(Weather.clearNight)\(Keys.IMAGE_TYPE)",
            Weather.cloudy.rawValue: "\(Weather.cloudy)\(Keys.IMAGE_TYPE)",
            Weather.fog.rawValue: "\(Weather.fog)\(Keys.IMAGE_TYPE)",
            Weather.partlyCloudyDay.rawValue: "\(Weather.partlyCloudyDay)\(Keys.IMAGE_TYPE)",
            Weather.partlyCloudyNight.rawValue: "\(Weather.partlyCloudyNight)\(Keys.IMAGE_TYPE)",
            Weather.rain.rawValue: "\(Weather.rain)\(Keys.IMAGE_TYPE)",
            Weather.sleet.rawValue: "\(Weather.sleet)\(Keys.IMAGE_TYPE)",
            Weather.snow.rawValue: "\(Weather.snow)\(Keys.IMAGE_TYPE)",
            Weather.wind.rawValue: "\(Weather.wind)\(Keys.IMAGE_TYPE)"]
        return dictOfPathIcons
    }
}

fileprivate enum Weather: String {
    case clearDay = "clear-day"
    case clearNight = "clear-night"
    case rain = "rain"
    case snow = "snow"
    case sleet = "sleet"
    case wind = "wind"
    case fog = "fog"
    case cloudy = "cloudy"
    case partlyCloudyDay = "partly-cloudy-day"
    case partlyCloudyNight = "partly-cloudy-night"
}

extension Keys {
    static let IMAGE_TYPE: String = ".png"
}
