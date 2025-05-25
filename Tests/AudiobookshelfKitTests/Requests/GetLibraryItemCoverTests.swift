//
//  GetLibraryItemCoverTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 8/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import AudiobookshelfKit
import Foundation
import Testing

struct GetLibraryItemCoverTests {
    @Test func request() throws {
        let request = try Audiobookshelf.Request.GetLibraryItemCover(id: "my-item")
            .asURLRequest(from: testURL, using: "my-token")

        let data = RequestData(request: request)

        #expect(data.baseURL == testURL.appendingPathComponent("api/items/my-item/cover"))
        #expect(data.headers == [
            "Accept": "image/*",
            "Authorization": "Bearer my-token",
        ])
    }

    @Test func request_optionalParameters() throws {
        let request = try Audiobookshelf.Request.GetLibraryItemCover(
            id: "my-item",
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
