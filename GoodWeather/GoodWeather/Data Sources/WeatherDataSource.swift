//
//  WeatherDataSource.swift
//  GoodWeather
//
//  Created by Prasad on 5/8/20.
//  Copyright © 2020 Prasad. All rights reserved.
//

import Foundation
import UIKit

class WeatherDataSource: NSObject, UITableViewDataSource {
    var cellIdentifier = "cell"
    private var weatherListVM: WeatherListViewModel
    
    init(_ viewModel: WeatherListViewModel) {
        self.weatherListVM = viewModel
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherListVM.weatherViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? WeatherCell else {
            return UITableViewCell()
        }
        let viewModel = self.weatherListVM.weatherViewModels[indexPath.row]
        viewModel.name.bind { cell.cityLabel.text = $0 }
        viewModel.main.temp.bind{ cell.temperatureLabel.text = $0.formatAsDegree }
        return cell
    }
}
