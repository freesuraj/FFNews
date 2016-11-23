//
//  ArticleListViewController.swift
//  FFNews
//
//  Created by Suraj Pathak on 23/11/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import UIKit

class ArticleListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    let refreshControl = UIRefreshControl()

    let newsRequest = FFNewsRequest(urlString: Constants.newsFetchUrl)
    
    fileprivate var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "FF News"
        prepareTableView()
        loadArticles()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func prepareTableView() {
        tableView.estimatedRowHeight = 500
        tableView.rowHeight = UITableViewAutomaticDimension
        refreshControl.attributedTitle =  NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(loadArticles), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func loadArticles() {
        if let req = newsRequest {
            req.send { [weak self] articles in
                self?.articles = articles
                self?.refresh()
            }
        }
    }
    
    func refresh() {
        refreshControl.endRefreshing()
        tableView.reloadData()
    }

}

extension ArticleListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.identifier, for: indexPath) as? ArticleTableViewCell {
            cell.customize(with: articles[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // do sth
        guard let url = URL(string: articles[indexPath.row].url) else {
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        let readerVc = ArticleReaderViewController(url: url)
        navigationController?.pushViewController(readerVc, animated: true)
    }
    
}
