//
//  GetLibraryItemsTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 14/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import AudiobookshelfKit
import Foundation
import Testing

struct GetLibraryItemsTests {
    @Test func request() throws {
        let request = try Audiobookshelf.Request.GetLibraryItems(
            libraryID: "my-library",
            limit: 5,
            page: 0
        )
        .asURLRequest(from: testURL, using: "my-token", customHeaders: [:])

        let data = RequestData(request: request)

        #expect(data.baseURL == testURL.appendingPathComponent("/api/libraries/my-library/items"))
        #expect(data.headers == [
            "Accept": "application/json",
            "Authorization": "Bearer my-token",
        ])

        #expect(data.queryItems == [
            "limit": "5",
            "page": "0",
        ])
    }

    @Test func request_optionalParameters() throws {
        let request = try Audiobookshelf.Request.GetLibraryItems(
            libraryID: "my-library",
            limit: 5,
            page: 1,
            sort: "media.metadata.title",
            desc: true,
            collapsedSeries: true,
            include: "rssfeed"
        )
        .asURLRequest(from: testURL, using: "my-token", customHeaders: [:])

        let data = RequestData(request: request)

        #expect(data.baseURL == testURL.appendingPathComponent("/api/libraries/my-library/items"))
        #expect(data.headers == [
            "Accept": "application/json",
            "Authorization": "Bearer my-token",
        ])

        #expect(data.queryItems == [
            "limit": "5",
            "page": "1",
            "sort": "media.metadata.title",
            "desc": "1",
            "collapsedSeries": "1",
            "include": "rssfeed",
        ])
    }

    @Test func response() throws {
        let response = try loadResponse(
            "library_items",
            for: Audiobookshelf.Request.GetLibraryItems.self
        )

        #expect(response.results.count == 22)

        let firstItem = response.results[0]
        #expect(firstItem.id == "bc0719db-2124-4ba2-9860-1b729cbfcc6e")
        #expect(firstItem.ino == "147827")
        #expect(firstItem.oldLibraryItemId == nil)
        #expect(firstItem.libraryId == "71288985-7f00-4a29-b671-836edde7d3a4")
        #expect(firstItem.folderId == "107b1c26-1f79-4118-acc5-531cc41a9f80")
        #expect(firstItem.path == "/Volumes/media/audiobooks_screenshots/JRR Tolkien/The Hobbit")
        #expect(firstItem.relPath == "JRR Tolkien/The Hobbit")
        #expect(firstItem.isFile == false)
        #expect(firstItem.mtimeMs == Date(timeIntervalSince1970: 1_596_375_037_000 / 1000))
        #expect(firstItem.ctimeMs == Date(timeIntervalSince1970: 1_596_375_037_000 / 1000))
        #expect(firstItem.birthtimeMs == Date(timeIntervalSince1970: 1_596_368_362_000 / 1000))
        #expect(firstItem.addedAt == Date(timeIntervalSince1970: 1_654_499_247_059 / 1000))
        #expect(firstItem.updatedAt == Date(timeIntervalSince1970: 1_713_354_157_355 / 1000))
        #expect(firstItem.isMissing == false)
        #expect(firstItem.isInvalid == false)
        #expect(firstItem.mediaType == .book)
        #expect(firstItem.media.id == "dbb1da04-8049-4fba-b9b6-bca66e5c9d6a")
        #expect(firstItem.media.metadata.title == "The Hobbit")
        #expect(firstItem.media.metadata.titleIgnorePrefix == "Hobbit, The")
        #expect(firstItem.media.metadata.subtitle == nil)
        #expect(firstItem.media.metadata.authorName == "JRR Tolkien")
        #expect(firstItem.media.metadata.authorNameLF == "Tolkien, JRR")
        #expect(firstItem.media.metadata.narratorName == "Rob Inglis")
        #expect(firstItem.media.metadata.seriesName == "")
        #expect(firstItem.media.metadata.genres == ["Fantasy"])
        #expect(firstItem.media.metadata.publishedYear == "1937")
        #expect(firstItem.media.metadata.publishedDate == nil)
        #expect(firstItem.media.metadata.publisher == nil)
        #expect(firstItem.media.metadata.description == nil)
        #expect(firstItem.media.metadata.isbn == nil)
        #expect(firstItem.media.metadata.asin == nil)
        #expect(firstItem.media.metadata.language == nil)
        #expect(firstItem.media.metadata.explicit == false)
        #expect(firstItem.media.metadata.abridged == false)
        #expect(firstItem.media.coverPath == "/Users/lcharlick/git/audiobookshelf/metadata/items/li_3xi3eu3m5ey3gcj45x/cover.png")
        #expect(firstItem.media.tags == [])
        #expect(firstItem.media.numTracks == 1)
        #expect(firstItem.media.numAudioFiles == 1)
        #expect(firstItem.media.numChapters == 19)
        #expect(firstItem.media.duration == 39720.024)
        #expect(firstItem.media.size == 18_226_998)
        #expect(firstItem.numFiles == 1)
        #expect(firstItem.size == 18_226_998)
    }
}
