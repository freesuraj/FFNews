//
//  Article.swift
//  FFNews
//
//  Created by Suraj Pathak on 23/11/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

struct Article {
    let byLine: String
    let tags: [String]
    let headline: String
    let abstract: String
    let url: String
    let relatedImageUrl: String?
}

fileprivate struct Image {
    let url: String
    let width: Int
}

extension Article {
    
    init?(raw: [String: Any]) {
        guard let byLine = raw["byLine"] as? String,
            let headline = raw["headline"] as? String,
            let abstract = raw["theAbstract"] as? String,
            let url = raw["url"] as? String else { return nil }
        self.byLine = byLine
        self.headline = headline
        self.abstract = abstract
        self.url = url
        
        // Makes an array of category names from category object array
        if let categories = raw["categories"] as? [[String: Any]] {
            tags = categories.flatMap { return $0["name"] as? String }
        } else {
            tags = []
        }
        
        // Gets array of related images, and calculates the smallest image comparing on their width
        if let images = raw["relatedImages"] as? [Any] {
            let images = images.flatMap { item -> Image? in
                guard let dict = item as? [String: Any],
                	let url = dict["url"] as? String,
                	let width = dict["width"] as? Int else { return nil }
                return Image(url: url, width: width)
            }
            if images.count > 0 {
                let minimumSizeImage = images.reduce(images[0], { value1, value2 -> Image in
                    return value1.width < value2.width ? value1 : value2
                })
                relatedImageUrl = minimumSizeImage.url
            } else {
                relatedImageUrl = nil
            }
        } else {
            relatedImageUrl = nil
        }
    }
    
}
