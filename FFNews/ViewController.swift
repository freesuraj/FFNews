//
//  ViewController.swift
//  FFNews
//
//  Created by Suraj Pathak on 23/11/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let newsRequest = FFNewsRequest(urlString: Constants.newsFetchUrl)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let req = newsRequest {
            req.send { articles in
                print("articles count \(articles.count)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

