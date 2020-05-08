//
//  WeatherViewModel.swift
//  GoodWeather
//
//  Created by Prasad on 5/3/20.
//  Copyright © 2020 Prasad. All rights reserved.
//

import Foundation

// type erasor technique

class Dynamic<T>: Decodable where T: Decodable {
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    func bind(listener: @escaping Listener)  {
        self.listener = listener
        self.listener?(value)
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    private enum CodingKeys: CodingKey {
        case value
    }
}

struct WeatherViewModel: Decodable {
    var name: Dynamic<String>
    var main: TemperatureViewModel
    
    private enum CodinKeys: String, CodingKey {
        case name
        case main
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodinKeys.self)
        name = Dynamic(try container.decode(String.self, forKey: .name))
        main = try container.decode(TemperatureViewModel.self, forKey: .main)
    }
}

struct TemperatureViewModel: Decodable {
    var temp: Dynamic<Double>
    var temp_min: Dynamic<Double>
    var temp_max: Dynamic<Double>
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodinKeys.self)
        temp = Dynamic(try container.decode(Double.self, forKey: .temp))
        temp_min = Dynamic(try container.decode(Double.self, forKey: .temp_min))
        temp_max = Dynamic(try container.decode(Double.self, forKey: .temp_max))
    }
    
    private enum CodinKeys: String, CodingKey {
        case temp
        case temp_min
        case temp_max
    }
}
