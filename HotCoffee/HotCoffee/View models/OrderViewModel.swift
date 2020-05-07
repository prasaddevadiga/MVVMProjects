//
//  OrderViewModel.swift
//  HotCoffee
//
//  Created by Prasad on 5/2/20.
//  Copyright © 2020 Prasad. All rights reserved.
//

import Foundation

class OrderListViewModel {
    var orderListVM: [OrderViewModel]
    
    init() {
        self.orderListVM = []
    }
}

extension OrderListViewModel {
    func order(at index: Int) -> OrderViewModel {
        return self.orderListVM[index]
    }
}

struct OrderViewModel {
    let order: Order
}

extension OrderViewModel {
    var name: String {
        return self.order.name
    }
    
    var email: String {
        return self.order.email
    }
    
    var type: String {
        return self.order.type.rawValue.capitalized
    }
    
    var size: String {
        return self.order.size.rawValue.capitalized
    }
}
