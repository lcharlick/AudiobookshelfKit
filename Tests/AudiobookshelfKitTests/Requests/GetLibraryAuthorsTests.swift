//
//  GetLibraryAuthorsTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 28/5/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import AudiobookshelfKit
import Foundation
import Testing

struct GetLibraryAuthorsTests {
    @Test func request() throws {
        let request = try Audiobookshelf.Request.GetLibraryAuthors(libraryID: "my-library")
            .asURLRequest(from: testURL, using: "my-token")

        let data = RequestData(request: request)

        #expect(data.baseURL == testURL.appendingPathComponent("api/libraries/my-library/authors"))
        #expect(data.headers == [
            "Accept": "application/json",
            "Authorization": "Bearer my-token",
        ])
    }

    @Test func response() throws {
        let response = try loadResponse(
            "library_authors",
            for: Audiobookshelf.Request.GetLibraryAuthors.self
        )

        #expect(response.authors.count == 3)
        let author = response.authors[0]
        #expect(author.id == "7e2f3c5b-9778-4505-8719-8fdce133600f")
        #expect(author.name == "Brandon Sanderson")
        #expect(author.description == nil)
        #expect(author.imagePath == nil)
        #expect(author.addedAt == Date(timeIntervalSince1970: 1_713_354_162_111 / 1000))
        #expect(author.updatedAt == Date(timeIntervalSince1970: 1_713_354_162_111 / 1000))
        #expect(author.libraryId == "71288985-7f00-4a29-b671-836edde7d3a4")
        #expect(author.numBooks == 3)
        #expect(author.lastFirst == "Sanderson, Brandon")
    }
}
