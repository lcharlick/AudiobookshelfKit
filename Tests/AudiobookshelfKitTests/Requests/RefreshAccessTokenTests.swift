//
//  RefreshAccessTokenTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 9/9/25.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

@testable import AudiobookshelfKit
import Foundation
import Testing

struct RefreshAccessTokenTests {
    @Test func request() throws {
        let request = try Audiobookshelf.Request.RefreshAccessToken(refreshToken: "test-refresh-token")
            .asURLRequest(from: testURL, using: nil, customHeaders: [:])

        let data = RequestData(request: request)

        #expect(data.baseURL == testURL.appendingPathComponent("auth/refresh"))

        #expect(data.headers == [
            "Accept": "application/json",
            "x-refresh-token": "test-refresh-token",
        ])

        #expect(data.httpBody == nil)
    }
}