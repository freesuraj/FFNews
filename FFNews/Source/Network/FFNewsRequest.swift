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
    
}

struct NewsParser {
    
    typealias NewsFetchBlock = (([Article]) -> Void)
    
    static func parse(json: Any, completion: @escaping NewsFetchBlock) {
        guard let response = json as? [String: Any],
            let assests = response["assets"] as? [[String: Any]] else {
                completion([])
                return
        }
        let newsList = assests.flatMap { return Article(raw: $0) }
        completion(newsList)
    }
    
}

extension FFNewsRequest {
    
    typealias NewsFetchBlock = (([Article]) -> Void)
    
    func send(_ completion: @escaping NewsFetchBlock) {
        NetworkManager.shared.request(request: self, success: { json in
            NewsParser.parse(json: json, completion: completion)
        }, failure: { _ in
            completion([])
        })
    }
    
}
