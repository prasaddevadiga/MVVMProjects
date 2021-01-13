//
//  CalenderDayViewModel.swift
//  CarFit
//
//  Created by Prasad on 1/9/21.
//  Copyright © 2021 Test Project. All rights reserved.
//

import Foundation

class CalenderDayViewModel {

    init(day: Day) {
        self.day = day
    }
    
    var day: Day
    
    var weekDay: String {
        return day.weekday
    }
    
    var dateNumber: String {
        return day.number
    }
    
    var date: Date {
        return day.date
    }
    
    var isDateSelected: Bool {
        return day.isSelected
    }
}
