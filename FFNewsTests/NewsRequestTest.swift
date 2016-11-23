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
    
    func testNetworkParser() {
        guard let raw = TestSampler.shared.valueForKeyPath("NewsList", "normal") as? [String: Any] else {
            XCTAssert(false)
            return
        }
//        sut.networkManager = StubPGNetworkManager(expectedJson: nil, expectedError: expectedError)
//        let expectation = self.expectation(description: "Block_Success")
//        sut.send(success: {_ in}, failure: { error in
//            XCTAssertEqual(error, expectedError)
//            expectation.fulfill()
//        })
//        waitForExpectations(timeout: 3, handler: nil)
    }
    
}
