//
//  WeatherListViewModel.swift
//  GoodWeather
//
//  Created by Prasad on 5/3/20.
//  Copyright © 2020 Prasad. All rights reserved.
//

import Foundation

class WeatherListViewModel {
    
    private(set) var weatherViewModels = [WeatherViewModel]()
    
    func addWeatherViewModel(_ vm: WeatherViewModel) {
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
    
    func updateUnit(selectedUnit: Unit)  {
        switch selectedUnit {
        case .celsius:
            self.convertToCelsius()
        case .fahrenheit:
            self.convertToFahrenheit()
        }
    }
    
    private func convertToCelsius() {
        weatherViewModels = self.weatherViewModels.map { vm in
            let weatherModel = vm
            weatherModel.main.temp.value = (weatherModel.main.temp.value - 32) * 5/9
            return weatherModel
        }
    }
    
    private func convertToFahrenheit() {
        weatherViewModels = self.weatherViewModels.map { vm in
            let weatherModel = vm
            weatherModel.main.temp.value = (weatherModel.main.temp.value * 9/5) + 32
            return weatherModel
        }
    }
}
