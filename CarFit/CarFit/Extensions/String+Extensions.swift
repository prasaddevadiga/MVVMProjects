//
//  String+Extensions.swift
//  CarFit
//
//  Created by Prasad on 1/7/21.
//  Copyright © 2021 Test Project. All rights reserved.
//

import Foundation

extension String {
    func getDateFromString()-> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let date = dateFormatter.date(from: self) else { return nil }
        return date
    }
}
