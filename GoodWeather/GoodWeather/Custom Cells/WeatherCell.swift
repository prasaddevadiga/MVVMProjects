//
//  WeatherCell.swift
//  GoodWeather
//
//  Created by Prasad on 5/3/20.
//  Copyright © 2020 Prasad. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    func confugure(_ vm: WeatherViewModel) {
        cityLabel.text = vm.name
        temperatureLabel.text = vm.main.temp.formatAsDegree
    }
}
