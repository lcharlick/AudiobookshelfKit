//
//  PingTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 8/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import AudiobookshelfKit
import Foundation
import Testing

struct PingTests {
    @Test func request() throws {
        let request = try Audiobookshelf.Request.Ping()
            .asURLRequest(from: testURL, using: "my-token", customHeaders: [:])

        let data = RequestData(request: request)

        #expect(data.baseURL == testURL.appendingPathComponent("ping"))
        #expect(data.headers == [
            "Accept": "application/json",
            "Authorization": "Bearer my-token",
        ])
    }

    @Test func response() throws {
        let data = try JSONEncoder().encode(["success": true])
        let response = try Audiobookshelf.Request.Ping.response(from: data)
        #expect(response.success == true)
    }
}
