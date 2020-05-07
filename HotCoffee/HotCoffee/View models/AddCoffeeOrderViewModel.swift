//
//  AddCoffeeOrderViewModel.swift
//  HotCoffee
//
//  Created by Prasad on 5/2/20.
//  Copyright © 2020 Prasad. All rights reserved.
//

import Foundation

struct AddCoffeeOrderViewModel {
    
    var name: String?
    var email: String?
    var selectedType: String?
    var selectedSize: String?
    
    var types: [String] { return CoffeeTyp.allCases.map { $0.rawValue.capitalized } }
    var sizes: [String] { return CoffeeSize.allCases.map { $0.rawValue } }
}
