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
        tableView.rowHeight = UITableViewAutomaticDimension
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle =  NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(loadArticles), for: .valueChanged)
        tableView.addSubview(refreshControl)
        //tableView.register(UINib.init(nibName: ArticleTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ArticleTableViewCell.identifier)
    }
    
    func loadArticles() {
        if let req = newsRequest {
            req.send { [weak self] articles in
                self?.articles = articles
                self?.tableView.reloadData()
            }
        }
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
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // do sth
    }
    
}
