//
//  GetAuthorImageTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 6/5/25.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

import AudiobookshelfKit
import Foundation
import Testing

struct GetAuthorImageTests {
    @Test func request() throws {
        let request = try Audiobookshelf.Request.GetAuthorImage(id: "my-author")
            .asURLRequest(from: testURL, using: "my-token")

        let data = RequestData(request: request)

        #expect(data.baseURL == testURL.appendingPathComponent("api/authors/my-author/image"))
        #expect(data.headers == [
            "Accept": "image/*",
            "Authorization": "Bearer my-token",
        ])
    }

    @Test func request_optionalParameters() throws {
        let request = try Audiobookshelf.Request.GetAuthorImage(
            id: "my-author",
            width: 100,
            height: 200,
            format: .jpeg,
            raw: true
        )
        .asURLRequest(from: testURL, using: "my-token")

        let data = RequestData(request: request)

        #expect(data.queryItems == [
            "width": "100",
            "height": "200",
            "format": "jpeg",
            "raw": "1",
        ])
    }
}