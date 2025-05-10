//
//  GetLibraryCollectionsTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 25/4/25.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

import AudiobookshelfKit
import XCTest

class GetLibraryCollectionsTests: BaseTestCase {
    func testRequest() throws {
        let request = try Audiobookshelf.Request.GetLibraryCollections(
            libraryID: "my-library",
            limit: 10,
            page: 1,
            sort: "name",
            desc: true,
            minified: true,
            include: "rssfeed"
        )
        .asURLRequest(from: testURL, using: "my-token")

        let data = RequestData(request: request)

        XCTAssertEqual(data.baseURL, testURL.appendingPathComponent("/api/libraries/my-library/collections"))
        XCTAssertEqual(data.headers, [
            "Accept": "application/json",
            "Authorization": "Bearer my-token",
        ])
        XCTAssertEqual(data.queryItems, [
            "limit": "10",
            "page": "1",
            "sort": "name",
            "desc": "1",
            "minified": "1",
            "include": "rssfeed",
        ])
    }

    func testRequest_optionalParameters() throws {
        let request = try Audiobookshelf.Request.GetLibraryCollections(
            libraryID: "my-library"
        )
        .asURLRequest(from: testURL, using: "my-token")

        let data = RequestData(request: request)

        XCTAssertEqual(data.baseURL, testURL.appendingPathComponent("/api/libraries/my-library/collections"))
        XCTAssertEqual(data.headers, [
            "Accept": "application/json",
            "Authorization": "Bearer my-token",
        ])
        XCTAssertEqual(data.queryItems, [:])
    }
} 