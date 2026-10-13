//
//  DecodingIssueTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 13/10/26.
//  Copyright © 2026 Lachlan Charlick. All rights reserved.
//

import AudiobookshelfKit
import Foundation
import Testing

struct DecodingIssueTests {
    @Test func cleanResponseHasNoIssues() throws {
        let decoded = try decodeWithIssues(Audiobookshelf.Request.GetLibraryItems.self, from: "library_items", editing: [])
        #expect(decoded.issues.isEmpty)
        #expect(decoded.value.results.count == 22)
    }

    /// Missing and null values are common and expected, so they aren't reported.
    @Test func missingAndNullValuesAreNotIssues() throws {
        let decoded = try decodeWithIssues(
            Audiobookshelf.Request.GetLibraryItem.self,
            from: "library_item",
            editing: [
                JSONEdit("PROLOGUE2-ADK", "updatedAt", .null),
                JSONEdit("PROLOGUE2-9ZF", "libraryFiles[0].metadata.birthtimeMs", .null),
                JSONEdit("PROLOGUE2-GAS", "media.audioFiles[0].ino", .remove),
                JSONEdit("test", "media.tags", .null),
                JSONEdit("test", "media.metadata", .remove),
            ]
        )
        #expect(decoded.issues.isEmpty)
    }

    @Test func convertedValuesAreNotIssues() throws {
        let decoded = try decodeWithIssues(
            Audiobookshelf.Request.GetLibraryItem.self,
            from: "library_item",
            editing: [
                JSONEdit("PROLOGUE2-GAR", "scanVersion", .number(2)),
                JSONEdit("test", "isInvalid", .number(0)),
                JSONEdit("test", "media.duration", .string("39720.5")),
            ]
        )
        #expect(decoded.issues.isEmpty)
    }

    @Test func unreadableValueIsReportedWithItsPath() throws {
        let decoded = try decodeWithIssues(
            Audiobookshelf.Request.GetLibraryItems.self,
            from: "library_items",
            editing: [
                JSONEdit("PROLOGUE2-CG2", "results[4].media.metadata.series", .array([["id": "series", "name": "Series"]])),
            ]
        )
        let issue = try #require(decoded.issues.only)
        #expect(issue.kind == .unreadableValue)
        #expect(issue.path == "results[4].media.metadata.series")
        guard case .typeMismatch = issue.error else {
            Issue.record("Expected a type mismatch, got \(issue.error)")
            return
        }
        #expect(decoded.value.results[4].media.metadata.series == nil)
    }

    @Test func skippedElementIsReportedWithTheFieldThatFailed() throws {
        let decoded = try decodeWithIssues(
            Audiobookshelf.Request.GetLibraryItems.self,
            from: "library_items",
            editing: [JSONEdit("test", "results[3].id", .number(3))]
        )
        let issue = try #require(decoded.issues.only)
        #expect(issue.kind == .skippedElement)
        #expect(issue.path == "results[3].id")
        #expect(decoded.value.skippedCount == 1)
    }

    @Test func skippedElementThatIsntAnObjectIsReportedAtItsIndex() throws {
        var json = try loadJSONObject("library_item")
        var media = try #require(json["media"] as? [String: Any])
        var chapters = try #require(media["chapters"] as? [Any])
        chapters.insert("not a chapter", at: 2)
        media["chapters"] = chapters
        json["media"] = media

        let decoded = try Audiobookshelf.Request.GetLibraryItem.decodedResponse(
            from: JSONSerialization.data(withJSONObject: json)
        )
        let issue = try #require(decoded.issues.only)
        #expect(issue.kind == .skippedElement)
        #expect(issue.path == "media.chapters[2]")
    }

    @Test(arguments: [
        ("updatedAt", JSONEdit.Change.string("yesterday")),
        ("media.audioFiles", .string("unexpected")),
        ("media", .string("unexpected")),
        ("isMissing", .number(2)),
    ])
    func unreadableValuesOfEachKindAreReported(path: String, change: JSONEdit.Change) throws {
        let decoded = try decodeWithIssues(
            Audiobookshelf.Request.GetLibraryItem.self,
            from: "library_item",
            editing: [JSONEdit("test", path, change)]
        )
        let issue = try #require(decoded.issues.only)
        #expect(issue.kind == .unreadableValue)
        #expect(issue.path == path)
    }

    @Test func responsesNotDecodedFromJSONHaveNoIssues() throws {
        let data = Data([0xFF, 0xD8, 0xFF])
        let decoded = try Audiobookshelf.Request.GetLibraryItemCover.decodedResponse(from: data)
        #expect(decoded.value == data)
        #expect(decoded.issues.isEmpty)
    }

    @Test func issuesBelongToTheDecodeThatFoundThem() throws {
        _ = try decodeWithIssues(
            Audiobookshelf.Request.GetLibraryItem.self,
            from: "library_item",
            editing: [JSONEdit("test", "isMissing", .number(2))]
        )
        let clean = try decodeWithIssues(Audiobookshelf.Request.GetLibraryItem.self, from: "library_item", editing: [])
        #expect(clean.issues.isEmpty)
    }

    @Test func decodingWithoutCollectingStillSucceeds() throws {
        let item = try decode(
            Audiobookshelf.Request.GetLibraryItem.self,
            from: "library_item",
            editing: [JSONEdit("test", "isMissing", .number(2))]
        )
        #expect(item.isMissing == nil)
    }

    @Test func descriptionNamesTheKindPathAndReason() throws {
        let decoded = try decodeWithIssues(
            Audiobookshelf.Request.GetLibraryItem.self,
            from: "library_item",
            editing: [JSONEdit("test", "updatedAt", .string("yesterday"))]
        )
        let issue = try #require(decoded.issues.only)
        #expect(issue.description == "Unreadable value at updatedAt: Expected a date in milliseconds or a date string.")
    }
}

private extension Array {
    /// The only element, or nil when there are none or several.
    var only: Element? {
        count == 1 ? first : nil
    }
}
