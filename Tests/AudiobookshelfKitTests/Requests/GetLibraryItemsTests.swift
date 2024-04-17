//
//  GetLibraryItemsTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 14/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import XCTest
import AudiobookshelfKit

class GetLibraryItemsTests: BaseTestCase {
    func testRequest() throws {
        let request = try Audiobookshelf.Request.GetLibraryItems(
            libraryID: "my-library",
            limit: 5,
            page: 0
        )
            .asURLRequest(from: testURL, using: "my-token")
        
        let data = RequestData(request: request)

        XCTAssertEqual(data.baseURL, testURL.appendingPathComponent("/api/libraries/my-library/items"))
        XCTAssertEqual(data.headers, [
            "Accept": "application/json",
            "Authorization": "Bearer my-token"
        ])

        XCTAssertEqual(data.queryItems, [
            "limit": "5",
            "page": "0"
        ])
    }

    func testRequest_optionalParameters() throws {
        let request = try Audiobookshelf.Request.GetLibraryItems(
            libraryID: "my-library",
            limit: 5,
            page: 1,
            sort: "media.metadata.title",
            desc: true,
            collapsedSeries: true,
            include: "rssfeed"
        )
            .asURLRequest(from: testURL, using: "my-token")
        
        let data = RequestData(request: request)

        XCTAssertEqual(data.baseURL, testURL.appendingPathComponent("/api/libraries/my-library/items"))
        XCTAssertEqual(data.headers, [
            "Accept": "application/json",
            "Authorization": "Bearer my-token"
        ])

        XCTAssertEqual(data.queryItems, [
            "limit": "5",
            "page": "1",
            "sort": "media.metadata.title",
            "desc": "1",
            "collapsedSeries": "1",
            "include": "rssfeed"
        ])
    }

    func testResponse() throws {
        let response = try loadResponse(
            "library_items",
            for: Audiobookshelf.Request.GetLibraryItems.self
        )

        XCTAssertEqual(response.results.count, 22)

        let firstItem = response.results[0]
        XCTAssertEqual(firstItem.id, "bc0719db-2124-4ba2-9860-1b729cbfcc6e")
        XCTAssertEqual(firstItem.ino, "147827")
        XCTAssertEqual(firstItem.oldLibraryItemId, nil)
        XCTAssertEqual(firstItem.libraryId, "71288985-7f00-4a29-b671-836edde7d3a4")
        XCTAssertEqual(firstItem.folderId, "107b1c26-1f79-4118-acc5-531cc41a9f80")
        XCTAssertEqual(firstItem.path, "/Volumes/media/audiobooks_screenshots/JRR Tolkien/The Hobbit")
        XCTAssertEqual(firstItem.relPath, "JRR Tolkien/The Hobbit")
        XCTAssertEqual(firstItem.isFile, false)
        XCTAssertEqual(firstItem.mtimeMs, Date(timeIntervalSince1970: 1596375037000 / 1000))
        XCTAssertEqual(firstItem.ctimeMs, Date(timeIntervalSince1970: 1596375037000 / 1000))
        XCTAssertEqual(firstItem.birthtimeMs, Date(timeIntervalSince1970: 1596368362000 / 1000))
        XCTAssertEqual(firstItem.addedAt, Date(timeIntervalSince1970: 1654499247059 / 1000))
        XCTAssertEqual(firstItem.updatedAt, Date(timeIntervalSince1970: 1713354157355 / 1000))
        XCTAssertEqual(firstItem.isMissing, false)
        XCTAssertEqual(firstItem.isInvalid, false)
        XCTAssertEqual(firstItem.mediaType, .book)
        XCTAssertEqual(firstItem.media.id, "dbb1da04-8049-4fba-b9b6-bca66e5c9d6a")
        XCTAssertEqual(firstItem.media.metadata.title, "The Hobbit")
        XCTAssertEqual(firstItem.media.metadata.titleIgnorePrefix, "Hobbit, The")
        XCTAssertEqual(firstItem.media.metadata.subtitle, nil)
        XCTAssertEqual(firstItem.media.metadata.authorName, "JRR Tolkien")
        XCTAssertEqual(firstItem.media.metadata.authorNameLF, "Tolkien, JRR")
        XCTAssertEqual(firstItem.media.metadata.narratorName, "Rob Inglis")
        XCTAssertEqual(firstItem.media.metadata.seriesName, "")
        XCTAssertEqual(firstItem.media.metadata.genres, ["Fantasy"])
        XCTAssertEqual(firstItem.media.metadata.publishedYear, "1937")
        XCTAssertEqual(firstItem.media.metadata.publishedDate, nil)
        XCTAssertEqual(firstItem.media.metadata.publisher, nil)
        XCTAssertEqual(firstItem.media.metadata.description, nil)
        XCTAssertEqual(firstItem.media.metadata.isbn, nil)
        XCTAssertEqual(firstItem.media.metadata.asin, nil)
        XCTAssertEqual(firstItem.media.metadata.language, nil)
        XCTAssertEqual(firstItem.media.metadata.explicit, false)
        XCTAssertEqual(firstItem.media.metadata.abridged, false)
        XCTAssertEqual(firstItem.media.coverPath, "/Users/lcharlick/git/audiobookshelf/metadata/items/li_3xi3eu3m5ey3gcj45x/cover.png")
        XCTAssertEqual(firstItem.media.tags, [])
        XCTAssertEqual(firstItem.media.numTracks, 1)
        XCTAssertEqual(firstItem.media.numAudioFiles, 1)
        XCTAssertEqual(firstItem.media.numChapters, 19)
        XCTAssertEqual(firstItem.media.duration, 39720.024)
        XCTAssertEqual(firstItem.media.size, 18226998)
        XCTAssertEqual(firstItem.numFiles, 1)
        XCTAssertEqual(firstItem.size, 18226998)
    }
}
