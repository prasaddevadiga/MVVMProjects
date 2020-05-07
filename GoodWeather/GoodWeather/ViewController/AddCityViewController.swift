//
//  AddCityViewController.swift
//  GoodWeather
//
//  Created by Prasad on 5/3/20.
//  Copyright © 2020 Prasad. All rights reserved.
//

import Foundation
import UIKit

protocol AddWeatherDelegate {
    func addWeatherDidSave(vm: WeatherViewModel)
}

class AddCityViewController: UIViewController {

    @IBOutlet weak var cityNameTextField: UITextField!
    var delegate: AddWeatherDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @IBAction func saveCityButtonPressed(_ sender: Any) {
        if let city = cityNameTextField.text, !city.isEmpty {
            if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=911f157a9efb4a280196dcb7077f0850&units=imperial") {
                
                let weatherResource = Resource<WeatherViewModel>(url: url) { data in
                    do {
                        let viewModel = try JSONDecoder().decode(WeatherViewModel.self, from: data)
                        return viewModel
                    } catch {
                        print(error.localizedDescription)
                        return nil
                    }
                }
                WebService().load(resource: weatherResource) { [weak self](object) in
                    guard let viewModel = object else { return }
                    self?.delegate?.addWeatherDidSave(vm: viewModel)
                    self?.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
