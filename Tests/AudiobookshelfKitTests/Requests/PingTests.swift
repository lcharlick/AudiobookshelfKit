//
//  PingTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 8/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import AudiobookshelfKit
import XCTest

class PingTests: BaseTestCase {
    func testRequest() throws {
        let request = try Audiobookshelf.Request.Ping()
            .asURLRequest(from: testURL, using: "my-token")

        let data = RequestData(request: request)

        XCTAssertEqual(data.baseURL, testURL.appendingPathComponent("ping"))
        XCTAssertEqual(data.headers, [
            "Accept": "application/json",
            "Authorization": "Bearer my-token",
        ])
    }

    func testResponse() throws {
        let data = try JSONEncoder().encode(["success": true])
        let response = try Audiobookshelf.Request.Ping.response(from: data)
        XCTAssertTrue(response.success)
    }
}
