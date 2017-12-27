//
//  SelectedCitiesTableViewController.swift
//  WeatherForecaster
//
//  Created by Anton on 16.12.17.
//  Copyright © 2017 Anton. All rights reserved.
//

import UIKit


class SelectedCitiesTableViewController: UITableViewController {
    
    var presenter: SelectedCitiesViewObserver?
    var citySelector: CitySelectorProvider?
    var reachability: ReachabilityCheckerProvider?
    var countOfCitiesForUpdating: Int = 0
    
    @IBOutlet var selectedCitiesTable: UITableView!
    var selectedCities = [City]()
    
    @IBAction func addCity(_ sender: UIBarButtonItem) {
        if ( reachability?.internetIsAvailable)! {
            citySelector?.selectCity()
        } else {
            showAlert()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension SelectedCitiesTableViewController {
    private func setup() {
        //TO DO
        // need to implement more efficient way to initialise dependencies because viewDidLoad can be called several times
        setupRefreshControl()
        setupReachability()
        setupPresenter()
        setupCitySelector()
        getListOfSelectedCities()
        updateForecasts()
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: #selector(self.updateForecasts), for: UIControlEvents.valueChanged)
    }
    
    private func setupReachability() {
        reachability = (UIApplication.shared.delegate as! AppDelegate).reachability as! ReachabilityCheckerProvider
    }
    
    private func setupPresenter() {
        let forecastProvider = DarkSkyForecastProvider()
        let persistentDataProvider = CoreDataPersistentDataProvider()
        presenter = WeatherForecasterPresenter(forecastProvider: forecastProvider, persistentDataProvider: persistentDataProvider) as! SelectedCitiesViewObserver
        presenter?.view = self
    }
    
    private func setupCitySelector() {
        citySelector = GooglePlacesCitySelectorProvider(presenterController: self, presenter: presenter! as! SelectorCityObserver)
    }
    
    private func getListOfSelectedCities() {
        selectedCities = (presenter?.getListOfSelectedCities())!
    }
    
    @objc private func updateForecasts() {
        if reachability?.internetIsAvailable != nil, (reachability?.internetIsAvailable)! != false {
            countOfCitiesForUpdating = selectedCities.count
            presenter?.updateWeatherForecast()
        } else {
            presenter?.fillSelectedCitiesWithSavedForecast()
            self.showAlert()
        }
    }
}

extension SelectedCitiesTableViewController {
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Keys.ForSelectedCitiesTableView.DEFAULT_COUNT_OF_SECTIONS
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedCities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Keys.ForSelectedCitiesTableView.SELECTED_CITIES_CELL_IDENTIFIER, for: indexPath) as! SelectedCityTableViewCell
        let city = selectedCities[indexPath.row]
        cell.configure(for: city)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            presenter?.needToDelete(selectedCities[indexPath.row])
            selectedCities.remove(at: indexPath.row)
            selectedCitiesTable.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let detailViewController = segue.destination as? CityWeatherDetailViewController {
            let city = (sender as? SelectedCityTableViewCell)?.city
            detailViewController.configure(for: city)
            detailViewController.title = city?.name
        }
    }
}

extension SelectedCitiesTableViewController: SelectedCitiesViewObservable {
    func wasUpdated(_ city: City) {
        let index = selectedCities.index{$0 === city}
        guard index != nil else {return}
        let indexPath = IndexPath(row: index!, section: 0)
        selectedCitiesTable.reloadRows(at: [indexPath], with: .fade)
        checkForStoppingRefreshControl()
    }
    
    func wasAdded(_ city: City) {
        selectedCities.append(city)
        let index = selectedCities.index{$0 === city}
        let indexPath = IndexPath(row: index!, section: 0)
        selectedCitiesTable.insertRows(at: [indexPath], with: .fade)
    }
}

extension SelectedCitiesTableViewController {
    //TO DO
    //need to implement more thread-safe and elegant way
    //through completion handler or smth like that
    private func checkForStoppingRefreshControl() {
        countOfCitiesForUpdating -= 1
        if countOfCitiesForUpdating <= 0 {
            DispatchQueue.main.async {
                self.refreshControl?.endRefreshing()
                self.countOfCitiesForUpdating = 0
            }
        }
    }
}


extension SelectedCitiesTableViewController {
    func showAlert() -> Void {
        let alert = UIAlertController(title: "Mobile Data is Turned Off", message: "Turn on mobile data or use Wi-Fi to \n access data", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            let settingsUrl = NSURL(string: UIApplicationOpenSettingsURLString)
            UIApplication.shared.open(settingsUrl as! URL, options: [:], completionHandler: nil)
        }
        alert.addAction(settingsAction)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`))
        self.present(alert, animated: true) {
            //DispatchQueue.main.async {
                self.refreshControl?.endRefreshing()
            //}
        }
    }
}

extension Keys {
    struct ForSelectedCitiesTableView {
        static let SELECTED_CITIES_CELL_IDENTIFIER: String = "SelectedCitiesCell"
        static let DEFAULT_COUNT_OF_SECTIONS: Int = 1
    }
}


