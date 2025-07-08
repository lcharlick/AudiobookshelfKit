//
//  UpdateBookmarkTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 25/5/2025.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

import AudiobookshelfKit
import Foundation
import Testing

struct UpdateBookmarkTests {
    @Test func request() throws {
        let request = try Audiobookshelf.Request.UpdateBookmark(
            libraryItemId: "8f2b0e4b-d484-47b8-b357-fbdcbc4e6458",
            time: 6446,
            title: "Chapter 1 - Updated Title"
        )
        .asURLRequest(from: testURL, using: "my-token")

        let data = RequestData(request: request)

        #expect(data.baseURL == testURL.appendingPathComponent("/api/me/item/8f2b0e4b-d484-47b8-b357-fbdcbc4e6458/bookmark"))
        #expect(data.httpMethod == "PATCH")
        #expect(data.headers == [
            "Accept": "application/json",
            "Authorization": "Bearer my-token",
            "Content-Type": "application/json",
        ])

        let body = try JSONDecoder().decode(
            Audiobookshelf.Request.UpdateBookmark.RequestBody.self,
            from: data.rawHttpBody!
        )
        #expect(body.time == 6446)
        #expect(body.title == "Chapter 1 - Updated Title")
    }

    @Test func response() throws {
        let response = try loadResponse(
            "update_bookmark",
            for: Audiobookshelf.Request.UpdateBookmark.self
        )

        #expect(response.libraryItemId == "8f2b0e4b-d484-47b8-b357-fbdcbc4e6458")
        #expect(response.title == "Hello, world!!")
        #expect(response.time == 6446)
        #expect(response.createdAt == Date(timeIntervalSince1970: 1_723_386_963_225 / 1000))
    }
}
