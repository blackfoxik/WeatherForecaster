//
//  CityWeatherDetailViewController.swift
//  WeatherForecaster
//
//  Created by Anton on 21.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import UIKit

class CityWeatherDetailViewController: UIViewController {

    @IBOutlet weak var mainInfoContainerView: UIView!
    @IBOutlet weak var summaryContainerView: UIView!
    @IBOutlet weak var weatherForecastsContainerView: UIView!
    var city: City?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let mainInfo = segue.destination as? MainInfoViewController {
            mainInfo.configure(for: city)
        }
        if let summaryInfo = segue.destination as? CurrentWeatherSummaryTableViewController {
            //summaryInfo.view.translatesAutoresizingMaskIntoConstraints = false;
            summaryInfo.configure(for: city)
        }
        if let forecastsInfo = segue.destination as? WeatherForecastTableViewController {
            forecastsInfo.configure(for: city)
        }
    }
    
    func configure(for city: City?) {
        self.city = city
    }
}
