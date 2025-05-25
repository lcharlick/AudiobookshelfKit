//
//  GetLibraryPlaylistsTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 25/5/2025.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

import AudiobookshelfKit
import Foundation
import Testing

struct GetLibraryPlaylistsTests {
    @Test func request() throws {
        let request = try Audiobookshelf.Request.GetLibraryPlaylists(
            libraryID: "my-library"
        )
        .asURLRequest(from: testURL, using: "my-token")

        let data = RequestData(request: request)

        #expect(data.baseURL == testURL.appendingPathComponent("/api/libraries/my-library/playlists"))
        #expect(data.headers == [
            "Accept": "application/json",
            "Authorization": "Bearer my-token",
        ])

        #expect(data.queryItems == [
            "limit": "0",
            "page": "0",
        ])
    }

    @Test func request_withPagination() throws {
        let request = try Audiobookshelf.Request.GetLibraryPlaylists(
            libraryID: "my-library",
            limit: 10,
            page: 2
        )
        .asURLRequest(from: testURL, using: "my-token")

        let data = RequestData(request: request)

        #expect(data.baseURL == testURL.appendingPathComponent("/api/libraries/my-library/playlists"))
        #expect(data.headers == [
            "Accept": "application/json",
            "Authorization": "Bearer my-token",
        ])

        #expect(data.queryItems == [
            "limit": "10",
            "page": "2",
        ])
    }

    @Test func response() throws {
        let response = try loadResponse(
            "library_playlists",
            for: Audiobookshelf.Request.GetLibraryPlaylists.self
        )

        #expect(response.total == 1)
        #expect(response.limit == 0)
        #expect(response.page == 0)
        #expect(response.results.count == 1)

        let playlist = response.results[0]
        #expect(playlist.id == "pl_qbwet64998s5ra6dcu")
        #expect(playlist.libraryId == "lib_c1u6t4p45c35rf0nzd")
        #expect(playlist.userId == "root")
        #expect(playlist.name == "Favorites")
        #expect(playlist.description == nil)
        #expect(playlist.coverPath == nil)
        #expect(playlist.lastUpdate == Date(timeIntervalSince1970: 1_669_623_431_313 / 1000))
        #expect(playlist.createdAt == Date(timeIntervalSince1970: 1_669_623_431_313 / 1000))

        #expect(playlist.items.count == 1)
        let playlistItem = playlist.items[0]
        #expect(playlistItem.libraryItemId == "li_8gch9ve09orgn4fdz8")
        #expect(playlistItem.episodeId == nil)

        let libraryItem = try #require(playlistItem.libraryItem)
        #expect(libraryItem.id == "li_8gch9ve09orgn4fdz8")
        #expect(libraryItem.ino == "649641337522215266")
        #expect(libraryItem.libraryId == "lib_c1u6t4p45c35rf0nzd")
        #expect(libraryItem.folderId == "fol_bev1zuxhb0j0s1wehr")
        #expect(libraryItem.path == "/audiobooks/Terry Goodkind/Sword of Truth/Wizards First Rule")
        #expect(libraryItem.relPath == "Terry Goodkind/Sword of Truth/Wizards First Rule")
        #expect(libraryItem.isFile == false)
        #expect(libraryItem.isMissing == false)
        #expect(libraryItem.isInvalid == false)
        #expect(libraryItem.mediaType == .book)

        #expect(libraryItem.media.metadata.title == "Wizards First Rule")
        #expect(libraryItem.media.metadata.titleIgnorePrefix == "Wizards First Rule")
        #expect(libraryItem.media.metadata.subtitle == nil)
        #expect(libraryItem.media.metadata.authorName == "Terry Goodkind")
        #expect(libraryItem.media.metadata.authorNameLF == "Goodkind, Terry")
        #expect(libraryItem.media.metadata.narratorName == "Sam Tsoutsouvas")
        #expect(libraryItem.media.metadata.seriesName == "Sword of Truth")
        #expect(libraryItem.media.metadata.genres == ["Fantasy"])
        #expect(libraryItem.media.metadata.publishedYear == "2008")
        #expect(libraryItem.media.metadata.publisher == "Brilliance Audio")
        #expect(libraryItem.media.metadata.asin == "B002V0QK4C")
        #expect(libraryItem.media.metadata.explicit == false)
        #expect(libraryItem.media.metadata.abridged == false)

        #expect(libraryItem.media.coverPath == "/metadata/items/li_8gch9ve09orgn4fdz8/cover.jpg")
        #expect(libraryItem.media.tags == ["Fantasy", "Epic"])
        #expect(libraryItem.media.duration == 33854.905)
        #expect(libraryItem.media.size == 268_824_228)
    }
}
