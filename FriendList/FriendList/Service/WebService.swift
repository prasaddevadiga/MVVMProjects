//
//  AppServerClient.swift
//  FriendList
//
//  Created by Prasad on 5/16/20.
//  Copyright © 2020 Prasad. All rights reserved.
//

import Foundation
import Alamofire

struct Resource<T: Decodable> {
    var url: URL
}

class WebService: NSObject {
    
    func load<T>(resource: Resource<T>, completion:@escaping ([T]?, Error?) -> Void) {
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    let friendList = try? JSONDecoder().decode([T].self, from: data)
                    completion(friendList, nil)
                }
                completion(nil, error)
            }
        }.resume()
    }
}
