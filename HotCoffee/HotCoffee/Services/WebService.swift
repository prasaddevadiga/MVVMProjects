//
//  WebService.swift
//  HotCoffee
//
//  Created by Prasad on 5/2/20.
//  Copyright © 2020 Prasad. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
}

enum HTTPMethod: String {
    case GET
    case POST
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

class WebService: NSObject {
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = resource.body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async { completion(.failure(.domainError)) }
                return
            }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async { completion(.success(result))}
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async { completion(.failure(.decodingError)) }
            }
        }.resume()
    }
}
