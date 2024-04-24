//
//  GetLibraryItemFileTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 8/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import AudiobookshelfKit
import XCTest

class GetLibraryItemFileTests: BaseTestCase {
    func testRequest() throws {
        let request = try Audiobookshelf.Request.GetLibraryItemFile(id: "my-item", ino: "my-inode")
            .asURLRequest(from: testURL, using: "my-token")

        let data = RequestData(request: request)

        XCTAssertEqual(data.baseURL, testURL.appendingPathComponent("api/items/my-item/file/my-inode"))
        XCTAssertEqual(data.headers, [
            "Accept": "audio/*",
            "Authorization": "Bearer my-token",
        ])
        XCTAssertEqual(data.queryItems, [:])
    }

    func testRequest_queryItemTokenStrategy() throws {
        let request = try Audiobookshelf.Request.GetLibraryItemFile(id: "my-item", ino: "my-inode")
            .asURLRequest(from: testURL, using: "my-token", tokenStrategy: .queryItem)

        let data = RequestData(request: request)

        XCTAssertEqual(data.baseURL, testURL.appendingPathComponent("api/items/my-item/file/my-inode"))
        XCTAssertEqual(data.headers, [
            "Accept": "audio/*",
        ])
        XCTAssertEqual(data.queryItems, ["token": "my-token"])
    }
}
