//
//  TableViewDataSource.swift
//  GoodWeather
//
//  Created by Prasad on 5/8/20.
//  Copyright © 2020 Prasad. All rights reserved.
//

import Foundation
import UIKit

class TableViewDataSource<CellType, ViewModel>: NSObject, UITableViewDataSource where CellType: UITableViewCell {
    
    let cellIdentifier: String
    var items: [ViewModel]
    let configureCell: (CellType, ViewModel) -> ()
    
    init(cellIdentifier: String, items: [ViewModel], configureCell: @escaping (CellType, ViewModel) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CellType else {
            return UITableViewCell()
        }
        let vm = items[indexPath.row]
        self.configureCell(cell, vm)
        return cell
    }
    
    func updateItems( _ items: [ViewModel]) {
        self.items = items
    }
}
