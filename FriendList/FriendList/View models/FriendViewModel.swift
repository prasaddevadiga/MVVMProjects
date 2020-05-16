//
//  FriendViewModel.swift
//  FriendList
//
//  Created by Prasad on 5/16/20.
//  Copyright © 2020 Prasad. All rights reserved.
//

import Foundation

struct FriendViewModel {
    private var friend: Friend
    
    init(friend: Friend) {
        self.friend = friend
    }
}

extension FriendViewModel {
    var firstName: String {
        return friend.firstname ?? ""
    }
    
    var idNumber: Int {
        return friend.id ?? 0
    }
    
    var lastname: String {
        friend.lastname ?? ""
    }
    
    var fullName: String {
        return firstName + " " + lastname
    }
    
    var phonenumber: String {
        return friend.phonenumber ?? ""
    }
}
