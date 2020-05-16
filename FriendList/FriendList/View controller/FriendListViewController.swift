//
//  ViewController.swift
//  FriendList
//
//  Created by Prasad on 5/16/20.
//  Copyright © 2020 Prasad. All rights reserved.
//

import UIKit

class FriendListViewController: UIViewController {

    var friendListVM = FriendListViewModel()
    @IBOutlet weak var friendListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        friendListVM.loadFriends { [weak self] completed in
            self?.friendListTableView.reloadData()
        }
    }
}

extension FriendListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendListVM.numberOfFriends
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as? FriendCell else {
            return UITableViewCell()
        }
        let vm = friendListVM.friend(at: indexPath.row)
        cell.fullNameLabel.text = vm?.fullName
        cell.phoneNumberLabel.text = vm?.phonenumber
        return cell
    }
}
