//
//  SettingsViewModel.swift
//  GoodWeather
//
//  Created by Prasad on 5/4/20.
//  Copyright © 2020 Prasad. All rights reserved.
//

import Foundation

enum Unit: String, CaseIterable {
    case celsius = "metric"
    case fahrenheit = "imperial"
}

extension Unit {
    var displayName: String {
        switch self {
        case .celsius:
            return "Celsius"
        case .fahrenheit:
            return "Fahrenheit"
        }
    }
}

struct SettingsViewModel {
    var units = Unit.allCases
    private var _selectedUnit: Unit = Unit.fahrenheit

    var selectedUnit: Unit {
        get {
            if let unit = UserDefaults.standard.object(forKey: "unit") as? String {
                return Unit(rawValue: unit)!
            }
            return _selectedUnit
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "unit")
            UserDefaults.standard.synchronize()
        }
    }
}
