//
//  WeatherListViewModel.swift
//  GoodWeather
//
//  Created by Prasad on 5/3/20.
//  Copyright © 2020 Prasad. All rights reserved.
//

import Foundation

struct WeatherListViewModel {
    private var weatherViewModels = [WeatherViewModel]()
    
    mutating func addWeatherViewModel(_ vm: WeatherViewModel) {
        self.weatherViewModels.append(vm)
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRows(_ section: Int) -> Int {
        return self.weatherViewModels.count
    }
    
    func weatherVM(at index: Int) -> WeatherViewModel {
        return self.weatherViewModels[index]
    }
    
    mutating func updateUnit(selectedUnit: Unit)  {
        switch selectedUnit {
        case .celsius:
            self.convertToCelsius()
        case .fahrenheit:
            self.convertToFahrenheit()
        }
    }
    
    mutating private func convertToCelsius() {
        weatherViewModels = self.weatherViewModels.map { vm in
            var weatherModel = vm
            weatherModel.main.temp = (weatherModel.main.temp - 32) * 5/9
            return weatherModel
        }
    }
    
    mutating private func convertToFahrenheit() {
        weatherViewModels = self.weatherViewModels.map { vm in
            var weatherModel = vm
            weatherModel.main.temp = (weatherModel.main.temp * 9/5) + 32
            return weatherModel
        }
    }
}
