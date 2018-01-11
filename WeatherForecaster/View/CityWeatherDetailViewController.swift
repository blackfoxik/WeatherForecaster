//
//  CityWeatherDetailViewController.swift
//  WeatherForecaster
//
//  Created by Anton on 21.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import UIKit

class CityWeatherDetailViewController: UIViewController {
  
    @IBOutlet weak var viewForContainers: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainInfoContainerView: UIView!
    @IBOutlet weak var summaryContainerView: UIView!
    @IBOutlet weak var weatherForecastsContainerView: UIView!
    var city: City?
    
    @IBOutlet weak var weatherForecastsContainerHeight: NSLayoutConstraint!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let mainInfo = segue.destination as? MainInfoViewController {
            mainInfo.configure(for: city)
        }
        if let summaryInfo = segue.destination as? CurrentWeatherSummaryTableViewController {
            //summaryInfo.view.translatesAutoresizingMaskIntoConstraints = false;
           // let size = scrollView.contentSize
            //scrollView.contentSize =  CGSize(width: scrollView.frame.size.width, height: size.height * 2);
            summaryInfo.configure(for: city)
            //self.view.setNeedsDisplay()
            //self.view.layoutIfNeeded()
        }
        if let forecastsInfo = segue.destination as? WeatherForecastTableViewController {
            forecastsInfo.view.translatesAutoresizingMaskIntoConstraints = false
            forecastsInfo.delegate = self
            forecastsInfo.configure(for: city)
        }
    }
    
    func configure(for city: City?) {
        self.city = city
    }
 
    override func preferredContentSizeDidChange(forChildContentContainer: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: forChildContentContainer)
        print(forChildContentContainer)
    }
    
    override func viewDidLayoutSubviews() {
        preferredContentSize = view.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        print("DETAIL VIEW DID LAYUOT \(preferredContentSize) \(Date())")
    }
    
}

extension CityWeatherDetailViewController: ForecastsContainerResizer {
    func apply(_ newHeight: CGFloat) {
        let c = weatherForecastsContainerHeight.constant
        weatherForecastsContainerHeight.constant = newHeight * 2
        let sc = scrollView.contentSize.height
        scrollView.contentSize.height = sc * 2
        let d = weatherForecastsContainerHeight.constant
        let isActive = weatherForecastsContainerHeight.isActive
        let sizeViewForContainer = viewForContainers.frame.size.height
        viewForContainers.frame.size.height = sizeViewForContainer * 2
        //performSegue(withIdentifier: "WeatherForecastTableSegue", sender: nil)
        self.view.layoutIfNeeded()
    }
    
    
}

protocol ForecastsContainerResizer {
    func apply(_ newHeight: CGFloat) -> Void
}
