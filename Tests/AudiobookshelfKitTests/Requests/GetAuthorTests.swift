//
//  GetAuthorTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 25/5/2025.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

import AudiobookshelfKit
import Foundation
import Testing

struct GetAuthorTests {
    @Test func request() throws {
        let request = try Audiobookshelf.Request.GetAuthor(
            id: "aut_z3leimgybl7uf3y4ab"
        )
        .asURLRequest(from: testURL, using: "my-token")

        let data = RequestData(request: request)

        #expect(data.baseURL == testURL.appendingPathComponent("/api/authors/aut_z3leimgybl7uf3y4ab"))
        #expect(data.headers == [
            "Accept": "application/json",
            "Authorization": "Bearer my-token",
        ])

        #expect(data.queryItems == [
            "include": "items",
        ])
    }

    @Test func response() throws {
        let response = try loadResponse(
            "author",
            for: Audiobookshelf.Request.GetAuthor.self
        )

        #expect(response.id == "aut_z3leimgybl7uf3y4ab")
        #expect(response.asin == "B000APZOQA")
        #expect(response.name == "Terry Goodkind")
        #expect(response.description == "Terry Goodkind is a #1 New York Times Bestselling Author and creator of the critically acclaimed masterwork, 'The Sword of Truth'. He has written 30+ major, bestselling novels, has been published in more than 20 languages world-wide, and has sold more than 26 Million books. 'The Sword of Truth' is a revered literary tour de force, comprised of 17 volumes, borne from over 25 years of dedicated writing.")
        #expect(response.imagePath == "/metadata/authors/aut_z3leimgybl7uf3y4ab/image.jpg")
        #expect(response.addedAt == Date(timeIntervalSince1970: 1_650_621_073_750 / 1000))
        #expect(response.updatedAt == Date(timeIntervalSince1970: 1_650_621_073_750 / 1000))
        #expect(response.libraryId == "lib_c1u6t4p45c35rf0nzd")

        #expect(response.libraryItems.count == 1)
        let libraryItem = response.libraryItems[0]
        #expect(libraryItem.id == "li_8gch9ve09orgn4fdz8")
        #expect(libraryItem.ino == "649641337522215266")
        #expect(libraryItem.libraryId == "lib_c1u6t4p45c35rf0nzd")
        #expect(libraryItem.path == "/audiobooks/Terry Goodkind/Sword of Truth/Wizards First Rule")
        #expect(libraryItem.mediaType == .book)
        #expect(libraryItem.media.metadata.title == "Wizards First Rule")
        #expect(libraryItem.media.metadata.authorName == "Terry Goodkind")
    }
}
