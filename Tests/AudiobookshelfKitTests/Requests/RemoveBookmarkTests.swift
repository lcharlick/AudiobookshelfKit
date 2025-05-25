//
//  RemoveBookmarkTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 25/5/2025.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

import AudiobookshelfKit
import Foundation
import Testing

struct RemoveBookmarkTests {
    @Test func request() throws {
        let request = try Audiobookshelf.Request.RemoveBookmark(
            libraryItemId: "8f2b0e4b-d484-47b8-b357-fbdcbc4e6458",
            time: 6446
        )
        .asURLRequest(from: testURL, using: "my-token")

        let data = RequestData(request: request)

        #expect(data.baseURL == testURL.appendingPathComponent("/api/me/item/8f2b0e4b-d484-47b8-b357-fbdcbc4e6458/bookmark"))
        #expect(data.httpMethod == "DELETE")
        #expect(data.headers == [
            "Accept": "application/json",
            "Authorization": "Bearer my-token",
        ])

        #expect(data.queryItems == [
            "time": "6446",
        ])
    }

    @Test func response() throws {
        let response = try loadResponse(
            "remove_bookmark",
            for: Audiobookshelf.Request.RemoveBookmark.self
        )

        #expect(response.success == true)
    }
}
