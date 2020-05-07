//
//  WebService.swift
//  GoodWeather
//
//  Created by Prasad on 5/3/20.
//  Copyright © 2020 Prasad. All rights reserved.
//

import Foundation

struct Resource<T> {
    let url: URL
    let parse: (Data) -> T?
}

final class WebService {
    
    func load<T>(resource: Resource<T>, completionHAndler: @escaping(T?) -> Void) {
        
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    print(data)
                    completionHAndler(resource.parse(data))
                } else {
                    completionHAndler(nil)
                }
            }
        }.resume()
        
    }
}
