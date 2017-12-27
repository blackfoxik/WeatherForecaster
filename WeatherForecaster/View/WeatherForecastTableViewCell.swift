//
//  WeatherForecastTableViewCell.swift
//  WeatherForecaster
//
//  Created by Anton on 21.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import UIKit

class WeatherForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var maxTemperature: UILabel!
    @IBOutlet weak var minTemperature: UILabel!
    var weatherForecast: ForecastForWeatherForecastTableView? {
        didSet {
            day?.text = weatherForecast?.dayOfTheWeek
            iconImage?.image = weatherForecast?.conditionalImage
            maxTemperature?.text = weatherForecast?.maxTemperature
            minTemperature?.text = weatherForecast?.minTemperature
        }
    }

    func configure(for weather: ForecastForWeatherForecastTableView?) {
        self.weatherForecast = weather
    }
}

