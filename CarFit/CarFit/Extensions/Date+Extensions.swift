//
//  Date+Extensions.swift
//  CarFit
//
//  Created by Prasad on 1/7/21.
//  Copyright © 2021 Test Project. All rights reserved.
//

import Foundation

extension Date {
    func getTimeFromDate() -> String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self)
        let minutes = calendar.component(.minute, from: self)
        return "\(String(format: "%02d", hour)):\(String(format: "%02d", minutes))"
    }
    
    func getCalenderDateString() -> String {
        
        guard Calendar.current.compare(self, to: Date(), toGranularity: .day) != .orderedSame else {
            return "Today"
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: self)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "dd-MMM-yyyy"
        return formatter.string(from: yourDate!)
    }
    
    mutating func addDays(n: Int) {
        self = Calendar.current.date(byAdding: .day, value: n, to: self) ?? Date()
    }

    func getAllDays() -> [Date] {
        var days = [Date]()
        let range = Calendar.current.range(of: .day, in: .month, for: self)!
        var day = Calendar.current.date(from: Calendar.current.dateComponents([.year,.month], from: self)) ?? Date()
        for _ in 1...range.count {
            days.append(day)
            day.addDays(n: 1)
        }
        return days
    }
    
    func weekDay() -> String {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "EEE"
        return dateFormatter1.string(from: self)
    }
    
    func monthDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLL"
        return dateFormatter.string(from: self)
    }
}
