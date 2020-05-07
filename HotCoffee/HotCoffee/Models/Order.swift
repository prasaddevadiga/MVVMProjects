//
//  Order.swift
//  HotCoffee
//
//  Created by Prasad on 5/2/20.
//  Copyright © 2020 Prasad. All rights reserved.
//

import Foundation

enum CoffeeTyp: String, Codable, CaseIterable {
    case Cappuccino
    case Expresso
    case Latte
    case Cortado
}

enum CoffeeSize: String, Codable, CaseIterable {
    case Small
    case Medium
    case Large
}

struct Order: Codable {
    var name: String
    var email: String
    var type: CoffeeTyp
    var size: CoffeeSize
}

extension Order {
    
    static var all: Resource<[Order]> {
        guard let url = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else { fatalError() }
        return Resource<[Order]>(url: url)
    }
    
    static func create(_ vm: AddCoffeeOrderViewModel) -> Resource<Order?> {
        let order = Order(vm)
        guard let url = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else { fatalError() }
        guard let data = try? JSONEncoder().encode(order) else { fatalError() }
        
        var resourse = Resource<Order?>(url: url)
        resourse.httpMethod = .POST
        resourse.body = data
        return resourse
    }
}

extension Order {
    init?(_ vm: AddCoffeeOrderViewModel) {
        guard let name = vm.name,
            let email = vm.email,
            let selectedType = CoffeeTyp(rawValue: vm.selectedType!.capitalized),
            let selectedSize = CoffeeSize(rawValue: vm.selectedSize!.capitalized) else {
                return nil
        }
        self.name = name
        self.email = email
        self.type = selectedType
        self.size = selectedSize
    }
}
