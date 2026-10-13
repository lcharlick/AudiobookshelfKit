//
//  SentryDecodingTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 13/10/26.
//  Copyright © 2026 Lachlan Charlick. All rights reserved.
//

import AudiobookshelfKit
import Foundation
import Testing

/// Responses that failed to decode for Prologue users, reproduced from the paths in their Sentry
/// reports. Each edit applies one reported failure to a fixture that otherwise decodes.
struct SentryDecodingTests {
    @Test(arguments: [
        JSONEdit("PROLOGUE2-9ZF", "libraryFiles[0].metadata.birthtimeMs", .null),
        JSONEdit("PROLOGUE2-ADK", "updatedAt", .null),
        JSONEdit("PROLOGUE2-39Q", "media.audioFiles[0].ino", .null),
        JSONEdit("PROLOGUE2-GAS", "media.audioFiles[0].ino", .remove),
        JSONEdit("PROLOGUE2-37Q", "media.audioFiles[0].channels", .null),
        JSONEdit("PROLOGUE2-2S8", "media.audioFiles[0].bitRate", .null),
        JSONEdit("PROLOGUE2-EZ6", "media.audioFiles[0].timeBase", .null),
        JSONEdit("PROLOGUE2-EEV", "media.audioFiles[0].metadata.birthtimeMs", .remove),
        JSONEdit("PROLOGUE2-GEM", "media.audioFiles[0].manuallyVerified", .remove),
        JSONEdit("PROLOGUE2-GAR", "scanVersion", .number(2)),
    ])
    func libraryItem(_ edit: JSONEdit) throws {
        let item = try decode(Audiobookshelf.Request.GetLibraryItem.self, from: "library_item", editing: [edit])
        #expect(item.id == "bc0719db-2124-4ba2-9860-1b729cbfcc6e")
        #expect(item.media.audioFiles.count == 1)
        #expect(item.media.$audioFiles.skippedCount == 0)
        #expect(item.libraryFiles.count == 1)
        #expect(item.$libraryFiles.skippedCount == 0)
    }

    /// The same item failures, in the batch request the library import uses.
    @Test(arguments: [
        JSONEdit("PROLOGUE2-9ZF", "libraryItems[0].libraryFiles[0].metadata.birthtimeMs", .null),
        JSONEdit("PROLOGUE2-ADK", "libraryItems[0].updatedAt", .null),
        JSONEdit("PROLOGUE2-39Q", "libraryItems[0].media.audioFiles[0].ino", .null),
        JSONEdit("PROLOGUE2-EZ6", "libraryItems[0].media.audioFiles[0].timeBase", .null),
        JSONEdit("PROLOGUE2-GEM", "libraryItems[0].media.audioFiles[0].manuallyVerified", .remove),
    ])
    func batchLibraryItems(_ edit: JSONEdit) throws {
        let response = try decode(
            Audiobookshelf.Request.BatchGetLibraryItems.self,
            from: "library_items_batch",
            editing: [edit]
        )
        #expect(response.libraryItems.count == 1)
        #expect(response.skippedCount == 0)
        #expect(response.libraryItems[0].media.audioFiles.count == 1)
        #expect(response.libraryItems[0].libraryFiles.count == 1)
    }

    @Test(arguments: [
        JSONEdit("PROLOGUE2-33Q", "results[0].ino", .null),
        JSONEdit("PROLOGUE2-FHP", "results[0].media.metadata.explicit", .null),
        JSONEdit("PROLOGUE2-CG2", "results[0].media.metadata.series", .array([["id": "series", "name": "Series"]])),
        JSONEdit("PROLOGUE2-1GV", "results[0].media.metadata.publishedDate", .string("2015-03-05T00:00:00.000Z")),
        JSONEdit("PROLOGUE2-5YD", "results[0].media.metadata.title", .null),
        JSONEdit("PROLOGUE2-GGS", "results[0].media.metadata.authorNameLF", .remove),
        JSONEdit("PROLOGUE2-FGB", "results[0].birthtimeMs", .remove),
    ])
    func libraryItems(_ edit: JSONEdit) throws {
        let response = try decode(Audiobookshelf.Request.GetLibraryItems.self, from: "library_items", editing: [edit])
        #expect(response.results.count == 22)
        #expect(response.skippedCount == 0)
    }

    @Test(arguments: [
        JSONEdit("PROLOGUE2-ADE", "results[0].books[0].libraryFiles[0].metadata.birthtimeMs", .null),
        JSONEdit("PROLOGUE2-EES", "results[0].books[0].media.audioFiles[0].metadata.birthtimeMs", .remove),
        JSONEdit("PROLOGUE2-EVC", "results[0].lastUpdate", .null),
        JSONEdit("PROLOGUE2-GAV", "results[0].libraryId", .remove),
        JSONEdit("PROLOGUE2-GGT", "limit", .remove),
    ])
    func libraryCollections(_ edit: JSONEdit) throws {
        let response = try decode(
            Audiobookshelf.Request.GetLibraryCollections.self,
            json: collectionsJSON(),
            editing: [edit]
        )
        #expect(response.results.map(\.id) == ["collection"])
        #expect(response.skippedCount == 0)
        #expect(response.results[0].books.count == 1)
        #expect(response.results[0].books[0].media.audioFiles.count == 1)
    }

    @Test(arguments: [
        JSONEdit("PROLOGUE2-GAD", "results[0].books[0].media.metadata.explicit", .null),
        JSONEdit("PROLOGUE2-G8J", "results[0].updatedAt", .null),
        JSONEdit("PROLOGUE2-GD1", "results[0].updatedAt", .remove),
        JSONEdit("PROLOGUE2-G4D", "results[0].books[0].ino", .null),
        JSONEdit("PROLOGUE2-GDJ", "results[0].addedAt", .null),
        JSONEdit("PROLOGUE2-GGV", "results[0].books[0].media.metadata.authorNameLF", .remove),
        JSONEdit(
            "PROLOGUE2-D5X",
            "results[0].books[0].media.metadata.series",
            .array([["id": "series", "name": "Series"]])
        ),
    ])
    func librarySeries(_ edit: JSONEdit) throws {
        let response = try decode(Audiobookshelf.Request.GetLibrarySeries.self, from: "library_series", editing: [edit])
        #expect(response.results.count == 1)
        #expect(response.skippedCount == 0)
        #expect(response.results[0].books.count == 1)
    }

    @Test(arguments: [
        JSONEdit("PROLOGUE2-428", "results[0].updatedAt", .remove),
        JSONEdit("PROLOGUE2-BGK", "results[0].updatedAt", .null),
        JSONEdit("PROLOGUE2-ADB", "results[0].addedAt", .null),
        JSONEdit("PROLOGUE2-GGQ", "limit", .remove),
    ])
    func libraryAuthors(_ edit: JSONEdit) throws {
        let response = try decode(
            Audiobookshelf.Request.GetLibraryAuthors.self,
            from: "library_authors",
            editing: [edit]
        )
        #expect(response.results.count == 3)
        #expect(response.skippedCount == 0)
    }

    @Test(arguments: [
        JSONEdit("PROLOGUE2-898", "libraries[0].folders[0].addedAt", .null),
        JSONEdit("PROLOGUE2-GGP", "libraries[0].folders[0].addedAt", .remove),
        JSONEdit("PROLOGUE2-G8H", "libraries[0].lastUpdate", .null),
        JSONEdit("PROLOGUE2-FF5", "libraries[0].settings.disableWatcher", .number(0)),
    ])
    func libraries(_ edit: JSONEdit) throws {
        let response = try decode(Audiobookshelf.Request.GetLibraries.self, from: "libraries", editing: [edit])
        #expect(response.libraries.count == 2)
        #expect(response.skippedCount == 0)
        #expect(response.libraries[0].folders.count == 1)
    }

    @Test(arguments: [
        JSONEdit("PROLOGUE2-50N", "mediaProgress[0].userId", .remove),
        JSONEdit("PROLOGUE2-GF1", "mediaProgress[0].libraryItemId", .null),
    ])
    func user(_ edit: JSONEdit) throws {
        let user = try decode(Audiobookshelf.Request.GetUser.self, from: "user", editing: [edit])
        #expect(user.mediaProgress.count == 1)
        #expect(user.$mediaProgress.skippedCount == 0)
    }

    @Test(arguments: [
        JSONEdit("PROLOGUE2-50K", "userId", .remove),
    ])
    func mediaProgress(_ edit: JSONEdit) throws {
        _ = try decode(Audiobookshelf.Request.GetMediaProgress.self, from: "media_progress", editing: [edit])
    }

    @Test(arguments: [
        JSONEdit("PROLOGUE2-EEN", "userDefaultLibraryId", .null),
        JSONEdit("PROLOGUE2-EAE", "serverSettings.scannerParseSubtitle", .remove),
    ])
    func login(_ edit: JSONEdit) throws {
        _ = try decode(Audiobookshelf.Request.OAuth2Callback.self, from: "login", editing: [edit])
    }

    @Test(arguments: [
        JSONEdit("PROLOGUE2-FZN", "libraryItemId", .remove),
    ])
    func createBookmark(_ edit: JSONEdit) throws {
        _ = try decode(Audiobookshelf.Request.CreateBookmark.self, from: "create_bookmark", editing: [edit])
    }
}

/// What the edited values decode as, for the failures where the value itself matters.
struct SentryDecodedValueTests {
    @Test func audioFileWithoutInoKeepsItsOtherValues() throws {
        let item = try decode(
            Audiobookshelf.Request.GetLibraryItem.self,
            from: "library_item",
            editing: [JSONEdit("PROLOGUE2-39Q", "media.audioFiles[0].ino", .null)]
        )
        let file = try #require(item.media.audioFiles.first)
        #expect(file.ino == nil)
        #expect(file.duration == 39720.024)
        #expect(file.codec == "aac")
    }

    @Test func nullDatesDecodeAsNil() throws {
        let item = try decode(
            Audiobookshelf.Request.GetLibraryItem.self,
            from: "library_item",
            editing: [
                JSONEdit("PROLOGUE2-ADK", "updatedAt", .null),
                JSONEdit("PROLOGUE2-9ZF", "libraryFiles[0].metadata.birthtimeMs", .null),
            ]
        )
        #expect(item.updatedAt == nil)
        #expect(item.libraryFiles[0].metadata.birthtimeMs == nil)
        #expect(item.libraryFiles[0].metadata.path?.hasSuffix("The Hobbit.m4a") == true)
    }

    @Test func numericScanVersionReadsAsString() throws {
        let item = try decode(
            Audiobookshelf.Request.GetLibraryItem.self,
            from: "library_item",
            editing: [JSONEdit("PROLOGUE2-GAR", "scanVersion", .number(2))]
        )
        #expect(item.scanVersion == "2")
    }

    @Test func numericBooleanReadsAsBool() throws {
        let response = try decode(
            Audiobookshelf.Request.GetLibraries.self,
            from: "libraries",
            editing: [JSONEdit("PROLOGUE2-FF5", "libraries[0].settings.disableWatcher", .number(1))]
        )
        #expect(response.libraries[0].settings.disableWatcher == true)
    }

    @Test func seriesArrayInListingDecodesAsNil() throws {
        let response = try decode(
            Audiobookshelf.Request.GetLibraryItems.self,
            from: "library_items",
            editing: [
                JSONEdit("PROLOGUE2-CG2", "results[0].media.metadata.series", .array([["id": "series", "name": "Series"]])),
            ]
        )
        #expect(response.results[0].media.metadata.series == nil)
        #expect(response.results[0].media.metadata.title != nil)
    }

    @Test func missingAuthorNameLFDecodesAsNil() throws {
        let response = try decode(
            Audiobookshelf.Request.GetLibraryItems.self,
            from: "library_items",
            editing: [JSONEdit("PROLOGUE2-GGS", "results[0].media.metadata.authorNameLF", .remove)]
        )
        #expect(response.results[0].media.metadata.authorNameLF == nil)
        #expect(response.results[0].media.metadata.authorName != nil)
    }

    @Test func nullDefaultLibraryDecodesAsNil() throws {
        let response = try decode(
            Audiobookshelf.Request.OAuth2Callback.self,
            from: "login",
            editing: [JSONEdit("PROLOGUE2-EEN", "userDefaultLibraryId", .null)]
        )
        #expect(response.userDefaultLibraryId == nil)
        #expect(response.user.mediaProgress.count == 2)
    }

    @Test func progressWithoutItemKeepsItsPosition() throws {
        let user = try decode(
            Audiobookshelf.Request.GetUser.self,
            from: "user",
            editing: [JSONEdit("PROLOGUE2-GF1", "mediaProgress[0].libraryItemId", .null)]
        )
        #expect(user.mediaProgress[0].libraryItemId == nil)
        #expect(user.mediaProgress[0].currentTime != nil)
    }
}

/// A page of collections holding the library item fixture, since there's no collections fixture.
func collectionsJSON() throws -> [String: Any] {
    [
        "results": [[
            "id": "collection",
            "libraryId": "library",
            "name": "Favourites",
            "books": [try loadJSONObject("library_item")],
            "lastUpdate": 1_700_000_000_000,
            "createdAt": 1_700_000_000_000,
        ]],
        "total": 1,
        "limit": 10,
        "page": 0,
    ]
}
