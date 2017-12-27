//
//  SelectedCityTableViewCell.swift
//  WeatherForecaster
//
//  Created by Anton on 21.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import UIKit

class SelectedCityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var curTemperature: UILabel!
    
    var city: City? {
        didSet {
            cityName?.text = city?.cityForSelectedCitiesTableView.cityName
            curTemperature?.text =  city?.cityForSelectedCitiesTableView.currentTemperature 
        }
    }
    func configure(for city: City?) {
        self.city = city
    }
}

