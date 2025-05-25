//
//  GetLibraryCollectionsTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 25/4/25.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

import AudiobookshelfKit
import Foundation
import Testing

struct GetLibraryCollectionsTests {
    @Test func request() throws {
        let request = try Audiobookshelf.Request.GetLibraryCollections(
            libraryID: "my-library",
            page: 1,
            limit: 10,
            sort: "name",
            desc: true,
            minified: true,
            include: "rssfeed"
        )
        .asURLRequest(from: testURL, using: "my-token")

        let data = RequestData(request: request)

        #expect(data.baseURL == testURL.appendingPathComponent("/api/libraries/my-library/collections"))
        #expect(data.headers == [
            "Accept": "application/json",
            "Authorization": "Bearer my-token",
        ])
        #expect(data.queryItems == [
            "limit": "10",
            "page": "1",
            "sort": "name",
            "desc": "1",
            "minified": "1",
            "include": "rssfeed",
        ])
    }

    @Test func request_optionalParameters() throws {
        let request = try Audiobookshelf.Request.GetLibraryCollections(
            libraryID: "my-library",
            page: 0,
            limit: 0
        )
        .asURLRequest(from: testURL, using: "my-token")

        let data = RequestData(request: request)

        #expect(data.baseURL == testURL.appendingPathComponent("/api/libraries/my-library/collections"))
        #expect(data.headers == [
            "Accept": "application/json",
            "Authorization": "Bearer my-token",
        ])
        #expect(data.queryItems == [
            "limit": "0",
            "page": "0",
        ])
    }
} 