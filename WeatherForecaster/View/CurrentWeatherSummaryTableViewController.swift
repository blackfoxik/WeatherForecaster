//
//  CurrentWeatherSummaryTableViewController.swift
//  WeatherForecaster
//
//  Created by Anton on 24.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import UIKit

class CurrentWeatherSummaryTableViewController: UITableViewController {
    var city: City?
    var weatherConditionals: CurrentWeatherForSummaryView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func configure(for city: City?) {
        self.city = city
        weatherConditionals = city?.getCurrentWeatherForSummaryView()
    }
}

extension CurrentWeatherSummaryTableViewController {
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return Keys.ForCurrentWeatherSummaryTableView.DEFAULT_COUNT_OF_SECTIONS
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherConditionals?.count ?? Keys.ForCurrentWeatherSummaryTableView.DEFAULT_COUNT_OF_ROWS
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Keys.ForCurrentWeatherSummaryTableView.TITLE_FOR_HEADER
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Keys.ForCurrentWeatherSummaryTableView.CURRENT_WEATHER_CELL_IDENTIFIER, for: indexPath)
        cell.textLabel?.text = weatherConditionals?[indexPath.row]?.key
        cell.detailTextLabel?.text = weatherConditionals?[indexPath.row]?.value
        return cell
    }
}

extension Keys {
    struct ForCurrentWeatherSummaryTableView {
        static let TITLE_FOR_HEADER: String = "Summary"
        static let CURRENT_WEATHER_CELL_IDENTIFIER: String = "CurrentWeatherSummaryCell"
        static let DEFAULT_COUNT_OF_SECTIONS: Int = 1
        static let DEFAULT_COUNT_OF_ROWS: Int = 0
    }
}
