//
//  GetLibrarySeriesTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 25/5/2025.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

import AudiobookshelfKit
import Foundation
import Testing

struct GetLibrarySeriesTests {
    @Test func request() throws {
        let request = try Audiobookshelf.Request.GetLibrarySeries(
            libraryID: "my-library",
            page: 0,
            limit: 10
        )
        .asURLRequest(from: testURL, using: "my-token", customHeaders: [:])

        let data = RequestData(request: request)

        #expect(data.baseURL == testURL.appendingPathComponent("/api/libraries/my-library/series"))
        #expect(data.headers == [
            "Accept": "application/json",
            "Authorization": "Bearer my-token",
        ])

        #expect(data.queryItems == [
            "page": "0",
            "limit": "10",
            "sort": "name",
            "desc": "0",
            "minified": "0",
        ])
    }

    @Test func request_withOptionalParameters() throws {
        let request = try Audiobookshelf.Request.GetLibrarySeries(
            libraryID: "my-library",
            page: 2,
            limit: 25,
            sort: "numBooks",
            desc: true,
            minified: true
        )
        .asURLRequest(from: testURL, using: "my-token", customHeaders: [:])

        let data = RequestData(request: request)

        #expect(data.baseURL == testURL.appendingPathComponent("/api/libraries/my-library/series"))
        #expect(data.headers == [
            "Accept": "application/json",
            "Authorization": "Bearer my-token",
        ])

        #expect(data.queryItems == [
            "page": "2",
            "limit": "25",
            "sort": "numBooks",
            "desc": "1",
            "minified": "1",
        ])
    }

    @Test func response() throws {
        let response = try loadResponse(
            "library_series",
            for: Audiobookshelf.Request.GetLibrarySeries.self
        )

        #expect(response.total == 1)
        #expect(response.limit == 10)
        #expect(response.page == 0)
        #expect(response.sortBy == "name")
        #expect(response.desc == false)
        #expect(response.minified == false)
        #expect(response.include == nil)
        #expect(response.results.count == 1)

        let series = response.results[0]
        #expect(series.id == "ser_cabkj4jeu8be3rap4g")
        #expect(series.name == "Sword of Truth")
        #expect(series.nameIgnorePrefix == "Sword of Truth")
        #expect(series.description == "The Sword of Truth is a series of epic fantasy novels by Terry Goodkind.")
        #expect(series.addedAt == Date(timeIntervalSince1970: 1_650_621_073_750 / 1000))
        #expect(series.updatedAt == Date(timeIntervalSince1970: 1_650_621_110_769 / 1000))
        #expect(series.libraryId == "lib_c1u6t4p45c35rf0nzd")

        #expect(series.books.count == 1)
        let book = series.books[0]
        #expect(book.id == "li_8gch9ve09orgn4fdz8")
        #expect(book.mediaType == .book)
        #expect(book.media.metadata.title == "Wizards First Rule")
        #expect(book.media.metadata.seriesName == "Sword of Truth")
    }
}
