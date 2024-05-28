//
//  GetLibraryAuthorsTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 28/5/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import AudiobookshelfKit
import XCTest

class GetLibraryAuthorsTests: BaseTestCase {
    func testRequest() throws {
        let request = try Audiobookshelf.Request.GetLibraryAuthors(libraryID: "my-library")
            .asURLRequest(from: testURL, using: "my-token")

        let data = RequestData(request: request)

        XCTAssertEqual(data.baseURL, testURL.appendingPathComponent("api/libraries/my-library/authors"))
        XCTAssertEqual(data.headers, [
            "Accept": "application/json",
            "Authorization": "Bearer my-token",
        ])
    }

    func testResponse() throws {
        let response = try loadResponse(
            "library_authors",
            for: Audiobookshelf.Request.GetLibraryAuthors.self
        )

        XCTAssertEqual(response.authors.count, 3)
        let author = response.authors[0]
        XCTAssertEqual(author.id, "7e2f3c5b-9778-4505-8719-8fdce133600f")
        XCTAssertEqual(author.name, "Brandon Sanderson")
        XCTAssertEqual(author.description, nil)
        XCTAssertEqual(author.imagePath, nil)
        XCTAssertEqual(author.addedAt, Date(timeIntervalSince1970: 1_713_354_162_111 / 1000))
        XCTAssertEqual(author.updatedAt, Date(timeIntervalSince1970: 1_713_354_162_111 / 1000))
        XCTAssertEqual(author.libraryId, "71288985-7f00-4a29-b671-836edde7d3a4")
        XCTAssertEqual(author.numBooks, 3)
        XCTAssertEqual(author.lastFirst, "Sanderson, Brandon")
    }
}
