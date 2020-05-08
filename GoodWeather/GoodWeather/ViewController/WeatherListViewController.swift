//
//  WeatherListViewController.swift
//  GoodWeather
//
//  Created by Prasad on 5/3/20.
//  Copyright © 2020 Prasad. All rights reserved.
//

import Foundation
import UIKit

class WeatherListViewController: UITableViewController {
    
    var weatherListViewModel = WeatherListViewModel()
    var dataSource: TableViewDataSource<WeatherCell, WeatherViewModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.dataSource = TableViewDataSource(cellIdentifier: "cell", items: weatherListViewModel.weatherViewModels) { (cell, vm) in
            vm.name.bind { cell.cityLabel.text = $0 }
            vm.main.temp.bind{ cell.temperatureLabel.text = $0.formatAsDegree }
        }
        tableView.dataSource = dataSource
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addWeather" {
            prepareSegueForAddWeather(segue)
        } else if segue.identifier == "settings" {
            prepareSegueForSettings(segue)
        } else if segue.identifier == "WeatherDetailsViewController" {
            prepareSegueForWeatherDetailsViewController(segue)
        }
    }
    
    private func prepareSegueForWeatherDetailsViewController(_ segue: UIStoryboardSegue) {
        guard let weatherDetailsViewController = segue.destination as? WeatherDetailsViewController,
            let indexpath = tableView.indexPathForSelectedRow else { return }
        
        let weatherVM = self.weatherListViewModel.weatherVM(at: indexpath.row)
        weatherDetailsViewController.weatherVM = weatherVM
    }
    
    private func prepareSegueForAddWeather(_ segue: UIStoryboardSegue) {
        if let nav = segue.destination as? UINavigationController, let addWeatherVC = nav.viewControllers.first as? AddCityViewController {
            addWeatherVC.delegate = self
        }
    }
    
    private func prepareSegueForSettings(_ segue: UIStoryboardSegue) {
        if let nav = segue.destination as? UINavigationController, let addWeatherVC = nav.viewControllers.first as? SettingsTableViewController {
            addWeatherVC.delegate = self
        }
    }
}

extension WeatherListViewController: SettingsDelegate {
    func settingsDone(vm: SettingsViewModel) {
        self.weatherListViewModel.updateUnit(selectedUnit: vm.selectedUnit)
        self.tableView.reloadData()
    }
}
 
extension WeatherListViewController: AddWeatherDelegate {
    func addWeatherDidSave(vm: WeatherViewModel) {
        weatherListViewModel.addWeatherViewModel(vm)
        self.dataSource?.updateItems(self.weatherListViewModel.weatherViewModels)
        self.tableView.reloadData()
    }
}
