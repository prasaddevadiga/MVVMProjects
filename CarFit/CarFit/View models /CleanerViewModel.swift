//
//  CleanerViewModel.swift
//  CarFit
//
//  Created by Prasad on 1/7/21.
//  Copyright © 2021 Test Project. All rights reserved.
//

import UIKit

struct CleanerViewModel {
    let cleaner: Cleaner
    
    init(with cleaner: Cleaner) {
        self.cleaner = cleaner
    }
    
    var houseOwnerName: String? {
        return (cleaner.houseOwnerFirstName?.capitalized ?? "") + " " + (cleaner.houseOwnerLastName?.capitalized ?? "")
    }
    
    var houseOwnerAddress: String? {
        return "\(cleaner.houseOwnerAddress?.capitalized ?? "") \(cleaner.houseOwnerZip?.capitalized ?? "") \(cleaner.houseOwnerCity?.capitalized ?? "")"
    }
    
    var arrivalTime: String? {
        guard let startTime = cleaner.startTimeUTC else { return nil }
        guard let date = startTime.getDateFromString() else { return nil }
        let startHour = date.getTimeFromDate()

        guard let expectedTime = cleaner.expectedTime?.replacingOccurrences(of: "/", with: "-") else {
            return startHour
        }
        return "\(startHour) / \(expectedTime)"
    }
    
    var taks: String? {
        let tasksNames = cleaner.tasks?.map{ $0.title }
        guard let taskList  = tasksNames as? [String] else { return "" }
        return taskList.joined(separator: ",")
    }
    
    var duration: String? {
        let tasksTime = cleaner.tasks?.map{ $0.timesInMinutes }
        guard let taskList  = tasksTime as? [Int] else { return "" }
        let sum = taskList.reduce(0, +)
        return "\(sum) min"
    }
    
    var taskStatus: String? {
        let visitState = VisitState(rawValue: cleaner.visitState ?? "")
        return visitState?.stausName
    }
    
    var taskStatusColor: UIColor? {
        guard let visitState = cleaner.visitState else { return nil }
        switch VisitState(rawValue: visitState) {
        case .Todo:
            return UIColor.todoOption
        case .InProgress:
            return UIColor.inProgressOption
        case .Done:
            return UIColor.doneOption
        default:
            return nil
        }
    }
}
