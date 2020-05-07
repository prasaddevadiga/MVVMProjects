//
//  WeatherViewModel.swift
//  GoodWeather
//
//  Created by Prasad on 5/3/20.
//  Copyright © 2020 Prasad. All rights reserved.
//

import Foundation

struct WeatherViewModel: Codable {
    var name: String
    var main: TemperatureViewModel
    
//    private enum CodinKeys: String, CodingKey {
//        case name
//        case currentTemperature = "main"
//    }
}

struct TemperatureViewModel: Codable {
    var temp: Double
    var temp_min: Double
    var temp_max: Double
    
//    private enum CodinKeys: String, CodingKey {
//        case temperature = "temp"
//        case temperatureMin = "temp_min"
//        case temperatureMax = "temp_max"
//    }
}
