//
//  Article.swift
//  GoodNews
//
//  Created by Prasad on 5/1/20.
//  Copyright © 2020 Prasad. All rights reserved.
//

import Foundation

struct ArticleList: Codable {
    var articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    var title, description: String?
}
