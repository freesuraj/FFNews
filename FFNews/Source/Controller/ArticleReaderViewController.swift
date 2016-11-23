//
//  ArticleReaderViewController.swift
//  FFNews
//
//  Created by Suraj Pathak on 24/11/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import UIKit
import WebKit

class ArticleReaderViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var spinner: UIActivityIndicatorView!
    let url: URL
    
    required init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        view = webView
        spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        spinner.hidesWhenStopped = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: spinner)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.startAnimating()
        let myRequest = URLRequest(url: url)
        webView.load(myRequest)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        spinner.stopAnimating()
    }
    
}
