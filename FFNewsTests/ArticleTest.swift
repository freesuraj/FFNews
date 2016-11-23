//
//  ArticleTest.swift
//  FFNewsTests
//
//  Created by Suraj Pathak on 23/11/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import XCTest
@testable import FFNews

class ArticleTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testArticleAttributes() {
        guard let rawArticle = TestSampler.shared.valueForKeyPath("Article", "normal") as? [String: Any] else {
            XCTAssert(false)
            return
        }
        let article = Article(raw: rawArticle)!
        XCTAssertEqual(article.id, "1015924351")
        XCTAssertEqual(article.timeStamp, 1479816000000)
        XCTAssertEqual(article.byLine, "Michael Bleby")
        XCTAssertEqual(article.headline, "Why the Greater Sydney Commission says the city has to change")
        XCTAssertEqual(article.abstract, "Cities throughout the wide brown land have revelled in the the developmental luxury of sprawl and cheap land, but now it's coming back to bite.")
        XCTAssertEqual(article.url, "http://www.afr.com/real-estate/why-the-greater-sydney-commission-says-the-city-has-to-change-20161122-gsus8v")
        XCTAssertEqual(article.tags, ["Residential", "Real Estate", "Transport", "Policy", "Roads", "Commercial", "Development", "NSW", "Rail"])
        XCTAssertNotNil(article.relatedImageUrl)
        XCTAssertEqual(article.relatedImageUrl!, "http://www.afr.com/content/dam/images/g/s/c/d/v/m/image.related.afrArticleLead.620x350.gsus8v.13zzqx.png/1479882016209.jpg")
    }
    
    func testArticleWithNoImage() {
        guard let rawArticle = TestSampler.shared.valueForKeyPath("Article", "noImage") as? [String: Any] else {
            XCTAssert(false)
            return
        }
        let article = Article(raw: rawArticle)!
        XCTAssertNil(article.relatedImageUrl)
    }
    
    func testArticleWithInvalidCategories() {
        guard let rawArticle = TestSampler.shared.valueForKeyPath("Article", "invalidCategories") as? [String: Any] else {
            XCTAssert(false)
            return
        }
        let article = Article(raw: rawArticle)!
        XCTAssertTrue(article.tags.isEmpty)
    }
    
}
