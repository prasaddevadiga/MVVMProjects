//
//  WeatherDetailsViewController.swift
//  GoodWeather
//
//  Created by Prasad on 5/8/20.
//  Copyright © 2020 Prasad. All rights reserved.
//

import UIKit

class WeatherDetailsViewController: UIViewController {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var mintemperatureLabel: UILabel!
    @IBOutlet weak var maxtemperatureLabel: UILabel!
    
    var weatherVM: WeatherViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherVM?.name.bind { self.cityNameLabel.text = $0 }
        weatherVM?.main.temp.bind { self.temperatureLabel.text = $0.formatAsDegree }
        weatherVM?.main.temp_max.bind { self.maxtemperatureLabel.text = $0.formatAsDegree }
        weatherVM?.main.temp_min.bind { self.mintemperatureLabel.text = $0.formatAsDegree }
    }
}
