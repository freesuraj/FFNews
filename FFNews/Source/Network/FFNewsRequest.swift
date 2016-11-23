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
    
    static func parsed(_ json: Any) -> [Article] {
        guard let response = json as? [String: Any],
            let assests = response["assets"] as? [[String: Any]] else {
                return []
        }
        return assests.flatMap { return Article(raw: $0) }
    }
    
}

extension FFNewsRequest {
    
    typealias NewsFetchBlock = (([Article]) -> Void)
    
    func send(_ completion: @escaping NewsFetchBlock) {
        NetworkManager.shared.request(request: self, success: { json in
            completion(NewsParser.parsed(json))
        }, failure: { _ in
            completion([])
        })
    }
    
}
