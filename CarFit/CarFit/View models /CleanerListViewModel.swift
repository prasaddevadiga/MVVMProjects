//
//  CleanerListViewModel.swift
//  CarFit
//
//  Created by Prasad on 1/6/21.
//  Copyright © 2021 Test Project. All rights reserved.
//

import UIKit
import CoreLocation

struct CleanerListViewModel {
    var cleanerListVM: [CleanerViewModel]
    private var filteredCleanerListVM: [CleanerViewModel]
    
    init() {
        self.cleanerListVM = []
        self.filteredCleanerListVM = []
    }
    
    mutating func selectedDate(date: Date) {
        self.filteredCleanerListVM = self.cleanerListVM.filter({ (model) -> Bool in
            guard let taskDate = model.cleaner.startTimeUTC?.getDateFromString() else { return false }
            return Calendar.current.compare(date, to: taskDate, toGranularity: .day) == .orderedSame
        })
    }
}

extension CleanerListViewModel {
    
    func totalCleaningTask() -> Int {
        return self.filteredCleanerListVM.count
    }
    
    func cleaner(at index: Int) -> CleanerViewModel {
        return self.filteredCleanerListVM[index]
    }
    
    func distanceToNextTask(at index: Int) -> String {
        guard (index + 1) < self.filteredCleanerListVM.count else { return "" }
        let currentTask = self.filteredCleanerListVM[index]
        let nextTask = self.filteredCleanerListVM[index + 1]
        
        let coordinate1 = CLLocation(latitude: currentTask.cleaner.houseOwnerLatitude ?? 0.0, longitude: currentTask.cleaner.houseOwnerLongitude ?? 0.0)
        let coordinate2 = CLLocation(latitude: nextTask.cleaner.houseOwnerLatitude ?? 0.0, longitude: nextTask.cleaner.houseOwnerLongitude ?? 0.0)
        return String(format: "%0.2f",(coordinate1.distance(from: coordinate2)/1609))           // converting the distance to miles
    }
}
