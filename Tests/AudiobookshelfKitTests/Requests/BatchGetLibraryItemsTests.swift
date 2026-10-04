//
//  BatchGetLibraryItemsTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 4/10/26.
//  Copyright © 2026 Lachlan Charlick. All rights reserved.
//

import AudiobookshelfKit
import Foundation
import Testing

struct BatchGetLibraryItemsTests {
    @Test func request() throws {
        let request = try Audiobookshelf.Request.BatchGetLibraryItems(libraryItemIDs: ["item-1", "item-2"])
            .asURLRequest(from: testURL, using: "my-token", customHeaders: [:])

        let data = RequestData(request: request)

        #expect(data.baseURL == testURL.appendingPathComponent("api/items/batch/get"))
        #expect(data.httpMethod == "POST")
        #expect(data.headers == [
            "Accept": "application/json",
            "Authorization": "Bearer my-token",
            "Content-Type": "application/json",
        ])

        let httpBody = try JSONDecoder().decode(
            Audiobookshelf.Request.BatchGetLibraryItems.Body.self,
            from: data.rawHttpBody!
        )
        #expect(httpBody.libraryItemIds == ["item-1", "item-2"])
    }

    @Test func response() throws {
        let response = try loadResponse(
            "library_items_batch",
            for: Audiobookshelf.Request.BatchGetLibraryItems.self
        )

        #expect(response.libraryItems.count == 1)
        let item = try #require(response.libraryItems.first)
        #expect(item.id == "bc0719db-2124-4ba2-9860-1b729cbfcc6e")
        #expect(item.media.metadata.title == "The Hobbit")
        #expect(!item.media.metadata.authors.isEmpty)
        #expect(!item.media.audioFiles.isEmpty)
    }
}
