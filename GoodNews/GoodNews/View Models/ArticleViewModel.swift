//
//  ArticleViewModel.swift
//  GoodNews
//
//  Created by Prasad on 5/1/20.
//  Copyright © 2020 Prasad. All rights reserved.
//

import Foundation

struct ArticleListViewModel {
    var articles: [Article]
}

extension ArticleListViewModel {
    var numberOfSections: Int {
        return 1
    }
    
    func numberRowsIn(_ section: Int) -> Int {
        return articles.count
    }
    
    func article(at index: Int) -> ArticleViewModel {
        return ArticleViewModel(articles[index])
    }
}



struct ArticleViewModel {
    private let article: Article
}

extension ArticleViewModel {
    init(_ article: Article) {
        self.article = article
    }
}

extension ArticleViewModel {
    var title: String? {
        return self.article.title
    }
    
    var description: String? {
        return self.article.description
    }
    
}
