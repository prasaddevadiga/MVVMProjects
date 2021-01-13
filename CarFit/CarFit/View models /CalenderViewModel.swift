//
//  CalenderViewModel.swift
//  CarFit
//
//  Created by Prasad on 1/7/21.
//  Copyright © 2021 Test Project. All rights reserved.
//

import Foundation

struct CalenderViewModel {
    fileprivate let calendar = Calendar(identifier: .gregorian)
    fileprivate var srolledMonthFirstDay = Date()
    
    var selectedDate = Date() {
        didSet {
            srolledMonthFirstDay = selectedDate
            calenderDays.forEach { (calenderDay) in
                calenderDay.day.isSelected = calendar.isDate(calenderDay.date, inSameDayAs: selectedDate)
            }
        }
    }
    var calenderDays = [CalenderDayViewModel]()
    
    mutating func populateCalenderForDate(currentDate: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        
        calenderDays = currentDate.getAllDays().map {
            return CalenderDayViewModel(day: Day(date: $0,
                                                 number: "\(Calendar.current.component(.day, from: $0))",
                                                 isSelected: calendar.isDate($0, inSameDayAs: selectedDate),
                                                 weekday: $0.weekDay()))
        }
    }
    
    mutating func getNextMonth() {
        var dateComponent = DateComponents()
        dateComponent.month = 1
        srolledMonthFirstDay = Calendar.current.date(byAdding: dateComponent, to: srolledMonthFirstDay) ?? Date()
        populateCalenderForDate(currentDate: srolledMonthFirstDay)
    }
    
    mutating func getPreviousMonth() {
        var dateComponent = DateComponents()
        dateComponent.month = -1
        srolledMonthFirstDay = Calendar.current.date(byAdding: dateComponent, to: srolledMonthFirstDay) ?? Date()
        populateCalenderForDate(currentDate: srolledMonthFirstDay)
    }
    
    func numberOfDays() -> Int {
        return calenderDays.count
    }
    
    func day(at index: Int) -> CalenderDayViewModel? {
        guard index < calenderDays.count else { return nil }
        return calenderDays[index]
    }
    
    func monthMetaData() -> String {
        return "\(srolledMonthFirstDay.monthDay()) \(Calendar.current.component(.year, from: srolledMonthFirstDay))"
    }
    
    func selectedDateIndex() -> Int? {
        let offsets = calenderDays.enumerated().filter({$0.element.isDateSelected == true }).map({ $0.offset })
        guard offsets.count > 0 else { return nil }
        return offsets.first
    }
}
