//
//  FriendViewModel.swift
//  FriendList
//
//  Created by Prasad on 5/16/20.
//  Copyright © 2020 Prasad. All rights reserved.
//

import Foundation

struct FriendViewModel {
    var friend: Friend
}

extension FriendViewModel {
    var firstName: String {
        friend.firstname ?? ""
    }
    
    var idNumber: Int {
        friend.id ?? 0
    }
    
    var lastname: String {
        friend.lastname ?? ""
    }
    
    var phonenumber: String {
        friend.phonenumber ?? ""
    }
}
