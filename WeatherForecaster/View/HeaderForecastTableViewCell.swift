//
//  HeaderForecastTableViewCell.swift
//  WeatherForecaster
//
//  Created by Anton on 25.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import UIKit

class HeaderForecastTableViewCell: UITableViewCell {
    
    var delegate: UserChangedCountOfDaysForecastHandler?

    @IBAction func setMaxCountOfDaysForecast(_ sender: UIButton) {
        setupButtonsColor(accordingTo: .max)
        delegate?.userChangedCountOfDaysForecast(to: .max)
    }
    @IBAction func setMinCountOfDaysForecast(_ sender: UIButton) {
        setupButtonsColor(accordingTo: .min)
        delegate?.userChangedCountOfDaysForecast(to: .min)
    }
    @IBOutlet weak var maxCountOfDayForecastButton: UIButton!
    @IBOutlet weak var minCountOfDayForecastButton: UIButton!
    
    func configureLabels(for variant: DaysForShowingVariant) {
        let minCountOFRows: Int = Keys.ForWeatherForecastTableView.MIN_COUNT_OF_DAY_FORECAST_ROWS
        let maxCountOFRows: Int = Keys.ForWeatherForecastTableView.MAX_COUNT_OF_DAY_FORECAST_ROWS
        self.minCountOfDayForecastButton.setTitle("\(minCountOFRows)d", for: .normal)
        self.maxCountOfDayForecastButton.setTitle("\(maxCountOFRows)d", for: .normal)
        setupButtonsColor(accordingTo: variant)
    }
    
    private func setupButtonsColor(accordingTo variant: DaysForShowingVariant) {
        if variant == .min {
            self.minCountOfDayForecastButton.setTitleColor(.black, for: .normal)
            self.maxCountOfDayForecastButton.setTitleColor(.gray, for: .normal)
        } else {
            self.minCountOfDayForecastButton.setTitleColor(.gray, for: .normal)
            self.maxCountOfDayForecastButton.setTitleColor(.black, for: .normal)
        }
    }
}

