//
//  GetLibraryItemCoverTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 8/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import AudiobookshelfKit
import XCTest

class GetLibraryItemCoverTests: BaseTestCase {
    func testRequest() throws {
        let request = try Audiobookshelf.Request.GetLibraryItemCover(id: "my-item")
            .asURLRequest(from: testURL, using: "my-token")

        let data = RequestData(request: request)

        XCTAssertEqual(data.baseURL, testURL.appendingPathComponent("api/items/my-item/cover"))
        XCTAssertEqual(data.headers, [
            "Accept": "image/*",
            "Authorization": "Bearer my-token",
        ])
    }

    func testRequest_optionalParameters() throws {
        let request = try Audiobookshelf.Request.GetLibraryItemCover(
            id: "my-item",
            width: 100,
            height: 200,
            format: .jpeg,
            raw: true
        )
        .asURLRequest(from: testURL, using: "my-token")

        let data = RequestData(request: request)

        XCTAssertEqual(data.queryItems, [
            "width": "100",
            "height": "200",
            "format": "jpeg",
            "raw": "1",
        ])
    }
}
