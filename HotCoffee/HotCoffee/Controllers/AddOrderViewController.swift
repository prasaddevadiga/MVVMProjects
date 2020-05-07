//
//  AddOrderViewController.swift
//  HotCoffee
//
//  Created by Prasad on 5/2/20.
//  Copyright © 2020 Prasad. All rights reserved.
//

import UIKit

protocol AddCoffeeOrderDelegate {
    func addCoffeeOrderViewControllerDidSave(order: Order, viewController: UIViewController)
    func addCoffeeOrderViewControllerDidClose(viewController: UIViewController)
}

class AddOrderViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    private var viewModel = AddCoffeeOrderViewModel()
    var delegate: AddCoffeeOrderDelegate?
    
    private var coffeeSizesSegmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        coffeeSizesSegmentControl = UISegmentedControl(items: self.viewModel.sizes)
        self.coffeeSizesSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.coffeeSizesSegmentControl)
        
        coffeeSizesSegmentControl.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20).isActive = true
        coffeeSizesSegmentControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    @IBAction func close() {
        delegate?.addCoffeeOrderViewControllerDidClose(viewController: self)
    }
    
    @IBAction func save() {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        self.viewModel.name = self.usernameTextfield.text
        self.viewModel.email = self.emailTextField.text
        self.viewModel.selectedSize = self.coffeeSizesSegmentControl.titleForSegment(at: coffeeSizesSegmentControl.selectedSegmentIndex)
        self.viewModel.selectedType = self.viewModel.types[indexPath.row]
        
        WebService().load(resource: Order.create(self.viewModel)) { [weak self](result) in
            switch result {
            case .success(let order):
                if let order = order, let weakSelf = self {
                    DispatchQueue.main.async {
                        weakSelf.delegate?.addCoffeeOrderViewControllerDidSave(order: order, viewController: weakSelf)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension AddOrderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.types.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.types[indexPath.row]
        return cell
    }
}
