//
//  NewsListTableViewController.swift
//  GoodNews
//
//  Created by Prasad on 5/1/20.
//  Copyright © 2020 Prasad. All rights reserved.
//

import Foundation
import UIKit

class NewsListTableViewController: UITableViewController {
    
    var articleList: ArticleListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        if let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=e2b64fe3aed442d18515886a736cbb76") {
            WebService().getArticles(url: url) { [weak self] (articles) in
                guard let articleList = articles else { return }
                self?.articleList = ArticleListViewModel(articles: articleList)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
            return UITableViewCell()
        }
        let article = articleList?.article(at: indexPath.row)
        cell.titleLabel.text = article?.title
        cell.descriptionLabel.text = article?.description
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return articleList?.numberOfSections ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleList?.numberRowsIn(section) ?? 0
    }
}
