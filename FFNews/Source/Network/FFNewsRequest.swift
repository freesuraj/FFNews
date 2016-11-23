//
//  FFNewsRequest.swift
//  FFNews
//
//  Created by Suraj Pathak on 23/11/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

// FFNewsRequest represent a network request to fetch a list of selected news
struct FFNewsRequest: NetworkRequest {
    
    let url: URL
    var method: HttpMethod = .get
    var body: Data?
    var headers: [String: String] = [:]
    
    init?(urlString: String) {
        guard let url = URL(string: urlString) else { return nil }
        self.url = url
    }
    
    typealias NewsFetchBlock = (([Article]) -> Void)
    
    func fetchNews(_ completion: @escaping NewsFetchBlock) {
        NetworkManager.shared.request(request: self, success: { json in
            guard let response = json as? [String: Any],
            let assests = response["assests"] as? [[String: Any]] else {
                	completion([])
                    return
            }
            let newsList = assests.flatMap { return Article(raw: $0) }
            completion(newsList)
        }, failure: { _ in
            completion([])
        })
    }
    
}
