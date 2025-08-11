//
//  GetLibraryItemFileTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 8/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import AudiobookshelfKit
import Foundation
import Testing

struct GetLibraryItemFileTests {
    @Test func request() throws {
        let request = try Audiobookshelf.Request.GetLibraryItemFile(id: "my-item", ino: "my-inode")
            .asURLRequest(from: testURL, using: "my-token", customHeaders: [:])

        let data = RequestData(request: request)

        #expect(data.baseURL == testURL.appendingPathComponent("api/items/my-item/file/my-inode"))
        #expect(data.headers == [
            "Accept": "audio/*",
            "Authorization": "Bearer my-token",
        ])
        #expect(data.queryItems == [:])
    }

    @Test func request_queryItemTokenStrategy() throws {
        let request = try Audiobookshelf.Request.GetLibraryItemFile(id: "my-item", ino: "my-inode")
            .asURLRequest(from: testURL, using: "my-token", tokenStrategy: .queryItem, customHeaders: [:])

        let data = RequestData(request: request)

        #expect(data.baseURL == testURL.appendingPathComponent("api/items/my-item/file/my-inode"))
        #expect(data.headers == [
            "Accept": "audio/*",
        ])
        #expect(data.queryItems == ["token": "my-token"])
    }
}
