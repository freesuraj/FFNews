//
//  FFNetworkManagerTest.swift
//  FFNews
//
//  Created by Suraj Pathak on 23/11/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import XCTest
@testable import FFNews

class NetworkManagerTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAsyncCall() {
        let urlString = "https://bruce-v2-mob.fairfaxmedia.com.au/1/coding_test/13ZZQX/full"
        let request = FFNewsRequest(urlString: urlString)
        guard let newsRequest = request else {
            XCTAssert(false)
            return
        }
        let networkManager = NetworkManager.shared
        let expectation = self.expectation(description: "Network_Success")
        networkManager.request(request: newsRequest, success: { json in
            let parsedResult = NewsParser.parsed(json)
            XCTAssertTrue(parsedResult.count > 0)
            expectation.fulfill()
            }) { _ in }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
