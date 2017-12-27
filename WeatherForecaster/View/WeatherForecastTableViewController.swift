//
//  WeatherForecastTableViewController.swift
//  WeatherForecaster
//
//  Created by Anton on 25.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import UIKit

class WeatherForecastTableViewController: UITableViewController {
    
    var city: City?
    var weatherForecastsForShowingToUser: [Int: ForecastForWeatherForecastTableView]?
    var weatherForecastsFromCity: [Int: ForecastForWeatherForecastTableView]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func configure(for city: City?) {
        self.city = city
        weatherForecastsFromCity = city?.getWeatherForecastsForView()
        weatherForecastsForShowingToUser = weatherForecastsFromCity
    }
}

extension WeatherForecastTableViewController {

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return Keys.ForWeatherForecastTableView.DEFAULT_COUNT_OF_SECTIONS
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherForecastsForShowingToUser?.count ?? Keys.ForWeatherForecastTableView.DEFAULT_COUNT_OF_ROWS
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: Keys.ForWeatherForecastTableView.HEADER_IDENTIFIER) as! HeaderForecastTableViewCell
        cell.delegate = self
        cell.configureLabels(for: .max)
        return cell
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Keys.ForWeatherForecastTableView.WEATHERFORECAST_CELL_IDENTIFIER, for: indexPath) as! WeatherForecastTableViewCell
        cell.configure(for: weatherForecastsForShowingToUser?[indexPath.row])
        return cell
    }
}

extension WeatherForecastTableViewController: UserChangedCountOfDaysForecastHandler {
    // TO DO
    // need to add saving to store state between launches
    func userChangedCountOfDaysForecast(to variant: DaysForShowingVariant) {

        if variant == .min {
            applyVariantMinDaysForShowing()
        }
        
        if variant == .max {
            applyVariantMaxDaysForShowing()
        }
    }
}

extension WeatherForecastTableViewController {
    private func applyVariantMinDaysForShowing() {
        let minCountOFRows: Int = Keys.ForWeatherForecastTableView.MIN_COUNT_OF_DAY_FORECAST_ROWS
        let maxCountOFRows: Int = Keys.ForWeatherForecastTableView.MAX_COUNT_OF_DAY_FORECAST_ROWS
        if weatherForecastsForShowingToUser?.count == maxCountOFRows {
            var pathIndexes = [IndexPath]()
            for index in minCountOFRows...maxCountOFRows - 1 {
                weatherForecastsForShowingToUser?.removeValue(forKey: index)
                let indexPath = IndexPath(row: index, section: 0)
                pathIndexes.append(indexPath)
            }
            self.tableView.deleteRows(at: pathIndexes, with: .none)
        }
    }
    
    private func applyVariantMaxDaysForShowing() {
        let minCountOFRows: Int = Keys.ForWeatherForecastTableView.MIN_COUNT_OF_DAY_FORECAST_ROWS
        let maxCountOFRows: Int = Keys.ForWeatherForecastTableView.MAX_COUNT_OF_DAY_FORECAST_ROWS
        if weatherForecastsForShowingToUser?.count == minCountOFRows {
            //add
            var pathIndexes = [IndexPath]()
            for index in minCountOFRows...maxCountOFRows - 1 {
                weatherForecastsForShowingToUser?[index] = weatherForecastsFromCity?[index]
                let indexPath = IndexPath(row: index, section: 0)
                pathIndexes.append(indexPath)
            }
            self.tableView.insertRows(at: pathIndexes, with: .none)
        }
    }
}

extension Keys {
    struct ForWeatherForecastTableView {
        static let HEADER_IDENTIFIER: String = "HeaderCell"
        static let WEATHERFORECAST_CELL_IDENTIFIER: String = "WeatherForecastCell"
        static let DEFAULT_COUNT_OF_SECTIONS: Int = 1
        static let DEFAULT_COUNT_OF_ROWS: Int = 0
        static let MIN_COUNT_OF_DAY_FORECAST_ROWS: Int = 3
        static let MAX_COUNT_OF_DAY_FORECAST_ROWS: Int = 7
    }
}

enum DaysForShowingVariant: String {
    case max = "max"
    case min = "min"
}
