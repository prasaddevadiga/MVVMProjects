//
//  WebService.swift
//  GoodNews
//
//  Created by Prasad on 5/1/20.
//  Copyright © 2020 Prasad. All rights reserved.
//

import Foundation

class WebService: NSObject {
    
    func  getArticles(url: URL, completion: @escaping ([Article]?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                print(data)
                 do {
                    let articleList = try JSONDecoder().decode(ArticleList.self, from: data)
                    completion(articleList.articles)
                } catch  {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}
