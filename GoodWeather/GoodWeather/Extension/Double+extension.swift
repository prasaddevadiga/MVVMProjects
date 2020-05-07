//
//  Double+extensiono.swift
//  GoodWeather
//
//  Created by Prasad on 5/4/20.
//  Copyright © 2020 Prasad. All rights reserved.
//

import Foundation

extension Double {
    var formatAsDegree: String {
        return String(format: "%.0f°", self)
    }
}
