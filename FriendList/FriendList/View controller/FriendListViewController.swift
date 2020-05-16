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
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath)
        let vm = friendListVM.friend(at: indexPath.row)
        cell.textLabel?.text = vm?.firstName
        return cell
    }
}
