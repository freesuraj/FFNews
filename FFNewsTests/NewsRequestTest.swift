//
//  FFNewsRequestTest.swift
//  FFNews
//
//  Created by Suraj Pathak on 23/11/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import XCTest
@testable import FFNews

class FFNewsRequestTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInvalidUrl() {
        let request = FFNewsRequest(urlString: "")
        XCTAssertNil(request)
    }
    
    func testValidUrl() {
        let urlString = "https://bruce-v2-mob.fairfaxmedia.com.au/1/coding_test/13ZZQX/full"
        let request = FFNewsRequest(urlString: urlString)
        XCTAssertNotNil(request)
        XCTAssertEqual(request!.url.absoluteString, urlString)
        XCTAssertEqual(request!.method.rawValue.lowercased(), "get")
        XCTAssertNil(request!.body)
    }
    
    func testNetworkParserValid() {
        guard let raw = TestSampler.shared.valueForKeyPath("NewsList", "normal") as? [String: Any] else {
            XCTAssert(false)
            return
        }
        
        let parsedResult = NewsParser.parsed(raw)
        XCTAssertEqual(parsedResult.count, 12)
        let article = parsedResult[0]
        XCTAssertEqual(article.id, "1015924351")
    }
    
    func testNetworkParserInvalid() {
        guard let raw = TestSampler.shared.valueForKeyPath("NewsList", "invalid") as? [String: Any] else {
            XCTAssert(false)
            return
        }
        
        let parsedResult = NewsParser.parsed(raw)
        XCTAssertEqual(parsedResult.count, 0)
    }
    
}
