//
//  OrdersTableViewController.swift
//  HotCoffee
//
//  Created by Prasad on 5/2/20.
//  Copyright © 2020 Prasad. All rights reserved.
//

import UIKit

class OrdersTableViewController: UITableViewController {

    var orderListVM = OrderListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateOrders()
    }

    private func populateOrders() {
        
        WebService().load(resource: Order.all) { [weak self] result in
            switch result {
            case .success(let orderList):
                self?.orderListVM.orderListVM = orderList.map (OrderViewModel.init)
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.orderListVM.orderListVM.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = self.orderListVM.order(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = vm.type
        cell.detailTextLabel?.text = vm.size
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nav = segue.destination as? UINavigationController,
            let viewController = nav.viewControllers.first as? AddOrderViewController else {
            return
        }
        viewController.delegate = self
    }
}

extension OrdersTableViewController: AddCoffeeOrderDelegate {
    func addCoffeeOrderViewControllerDidSave(order: Order, viewController: UIViewController) {
        self.orderListVM.orderListVM.append(OrderViewModel(order: order))
        self.tableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    
    func addCoffeeOrderViewControllerDidClose(viewController: UIViewController) {
        self.dismiss(animated: true, completion: nil)
    }
}
