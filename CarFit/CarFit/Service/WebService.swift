//
//  WebService.swift
//  CarFit
//
//  Created by Prasad on 1/6/21.
//  Copyright © 2021 Test Project. All rights reserved.
//

import UIKit

import Foundation

enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
}

enum HTTPMethod: String {
    case GET
}

struct Resource<T: Codable> {
    let url: URL
    var httpMethod: HTTPMethod = .GET
    var body: Data? = nil
}

extension Resource {
    init(url: URL) {
        self.url = url
    }
}

// This method can be used to call server API by changing the implementation
class WebService: NSObject {
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) {
        do {
            let data = try Data(contentsOf: resource.url, options: .mappedIfSafe)
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(.success(result))
        } catch {
            completion(.failure(NetworkError.decodingError))
        }
    }
}

