//
//  MainInfoViewController.swift
//  WeatherForecaster
//
//  Created by Anton on 24.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import UIKit

class MainInfoViewController: UIViewController {
    var city: City?
    @IBOutlet weak var curTemperature: UILabel!
    @IBOutlet weak var curWeatherSummary: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOutlets()
    }
    func configure(for city: City?) {
        self.city = city
    }
    private func setupOutlets() -> Void {
        self.curTemperature.text = city?.currentWeatherForMainInfoView.currentTemperature
        self.curWeatherSummary.text = city?.currentWeatherForMainInfoView.shortDescription
    }
}
