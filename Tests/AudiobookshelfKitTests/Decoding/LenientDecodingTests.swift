//
//  LenientDecodingTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 13/10/26.
//  Copyright © 2026 Lachlan Charlick. All rights reserved.
//

@testable import AudiobookshelfKit
import Foundation
import Testing

struct LenientDecodingTests {
    // MARK: - Pages of results

    @Test func pageSkipsResultsWithoutAnID() throws {
        let response = try decode(
            Audiobookshelf.Request.GetLibraryItems.self,
            from: "library_items",
            editing: [JSONEdit("test", "results[3].id", .remove)]
        )
        #expect(response.results.count == 21)
        #expect(response.skippedCount == 1)
        #expect(response.total == 22)
    }

    @Test func batchSkipsItemsWithoutAnID() throws {
        let response = try decode(
            Audiobookshelf.Request.BatchGetLibraryItems.self,
            from: "library_items_batch",
            editing: [JSONEdit("test", "libraryItems[0].id", .null)]
        )
        #expect(response.libraryItems.isEmpty)
        #expect(response.skippedCount == 1)
    }

    /// A response without results isn't an empty page: reading it as one would look like every
    /// book had been removed from the server.
    @Test(arguments: [JSONEdit.Change.remove, .null, .string("unexpected")])
    func pageWithoutResultsFails(_ change: JSONEdit.Change) throws {
        #expect(throws: DecodingError.self) {
            try decode(
                Audiobookshelf.Request.GetLibraryItems.self,
                from: "library_items",
                editing: [JSONEdit("test", "results", change)]
            )
        }
    }

    @Test func batchWithoutItemsFails() throws {
        #expect(throws: DecodingError.self) {
            try decode(
                Audiobookshelf.Request.BatchGetLibraryItems.self,
                from: "library_items_batch",
                editing: [JSONEdit("test", "libraryItems", .remove)]
            )
        }
    }

    @Test func missingTotalCountsSkippedResults() throws {
        let response = try decode(
            Audiobookshelf.Request.GetLibraryItems.self,
            from: "library_items",
            editing: [JSONEdit("test", "total", .remove), JSONEdit("test", "results[0].id", .remove)]
        )
        #expect(response.total == 22)
    }

    // MARK: - Nested values

    @Test func missingMediaDecodesAsEmpty() throws {
        let item = try decode(
            Audiobookshelf.Request.GetLibraryItem.self,
            from: "library_item",
            editing: [JSONEdit("test", "media", .remove)]
        )
        #expect(item.media.metadata.title == nil)
        #expect(item.media.audioFiles.isEmpty)
        #expect(item.media.metadata.authors.isEmpty)
    }

    @Test(arguments: [JSONEdit.Change.remove, .null, .string("unexpected")])
    func unreadableArrayDecodesAsEmpty(_ change: JSONEdit.Change) throws {
        let item = try decode(
            Audiobookshelf.Request.GetLibraryItem.self,
            from: "library_item",
            editing: [JSONEdit("test", "media.audioFiles", change)]
        )
        #expect(item.media.audioFiles.isEmpty)
        #expect(item.media.duration == 39720.024)
    }

    @Test func arraySkipsElementsThatArentObjects() throws {
        var json = try loadJSONObject("library_item")
        var media = try #require(json["media"] as? [String: Any])
        var chapters = try #require(media["chapters"] as? [Any])
        chapters.insert("not a chapter", at: 1)
        media["chapters"] = chapters
        json["media"] = media

        let item = try decode(Audiobookshelf.Request.GetLibraryItem.self, json: json, editing: [])
        #expect(item.media.chapters.count == 19)
        #expect(item.media.$chapters.skippedCount == 1)
        #expect(item.media.chapters.map(\.id) == Array(0..<19))
    }

    @Test func unknownEnumValueDecodesAsNil() throws {
        let item = try decode(
            Audiobookshelf.Request.GetLibraryItem.self,
            from: "library_item",
            editing: [JSONEdit("test", "mediaType", .string("audiodrama"))]
        )
        #expect(item.mediaType == nil)
    }

    // MARK: - Coercion

    @Test func scalarsReadFromOtherJSONTypes() throws {
        let item = try decode(
            Audiobookshelf.Request.GetLibraryItem.self,
            from: "library_item",
            editing: [
                JSONEdit("test", "isMissing", .string("true")),
                JSONEdit("test", "isInvalid", .number(0)),
                JSONEdit("test", "size", .string("18226998")),
                JSONEdit("test", "media.duration", .string("39720.5")),
                JSONEdit("test", "media.audioFiles[0].ino", .number(147_831)),
                JSONEdit("test", "media.audioFiles[0].bitRate", .number(2090)),
                JSONEdit("test", "media.metadata.publishedYear", .number(1937)),
            ]
        )
        #expect(item.isMissing == true)
        #expect(item.isInvalid == false)
        #expect(item.size == 18_226_998)
        #expect(item.media.duration == 39720.5)
        #expect(item.media.audioFiles[0].ino == "147831")
        #expect(item.media.audioFiles[0].bitRate == 2090)
        #expect(item.media.metadata.publishedYear == "1937")
    }

    @Test(arguments: [JSONEdit.Change.number(2), .string("yes"), .number(1.5)])
    func unreadableScalarDecodesAsNil(_ change: JSONEdit.Change) throws {
        let item = try decode(
            Audiobookshelf.Request.GetLibraryItem.self,
            from: "library_item",
            editing: [JSONEdit("test", "isMissing", change), JSONEdit("test", "media.size", change)]
        )
        #expect(item.isMissing == nil)
        if case .number(2) = change {
            #expect(item.media.size == 2)
        } else {
            #expect(item.media.size == nil)
        }
    }

    // MARK: - Encoding

    @Test func encodingLeavesOutNilValues() throws {
        let item = try decode(
            Audiobookshelf.Request.GetLibraryItem.self,
            from: "library_item",
            editing: [JSONEdit("test", "updatedAt", .null)]
        )
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .millisecondsSince1970
        let data = try encoder.encode(item)
        let json = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

        #expect(json["updatedAt"] == nil)
        #expect(json["oldLibraryItemId"] == nil)
        #expect(json["id"] as? String == item.id)
        #expect(try Audiobookshelf.Request.GetLibraryItem.response(from: data) == item)
    }
}
