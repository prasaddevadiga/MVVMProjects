//
//  FriendListViewModel.swift
//  FriendList
//
//  Created by Prasad on 5/16/20.
//  Copyright © 2020 Prasad. All rights reserved.
//

import Foundation

class FriendListViewModel: NSObject {
    private var friendVM: [FriendViewModel]?
}

extension FriendListViewModel {
    static var all: Resource<Friend> {
        guard let url = URL(string: "http://friendservice.herokuapp.com/listFriends") else {
            fatalError("URL not found")
        }
        return Resource(url: url)
    }
    
    func loadFriends(completionHandler: @escaping(_ completed: Bool) -> Void) {
        WebService().load(resource: FriendListViewModel.all) { [weak self] friendList, error in
            if let friendList = friendList {
                
                self?.friendVM = friendList.map { FriendViewModel(friend: $0) }
            }
            completionHandler(true)
        }
    }
    
    func friend(at index: Int) -> FriendViewModel? {
        guard (friendVM?.count ?? 0) > index else { return nil }
        return friendVM?[index]
    }
    
    var numberOfFriends: Int {
        return friendVM?.count ?? 0
    }
}

