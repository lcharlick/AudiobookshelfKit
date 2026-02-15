//
//  GetLibraryItemTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 14/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import AudiobookshelfKit
import Foundation
import Testing

struct GetLibraryItemTests {
    @Test func request() throws {
        let request = try Audiobookshelf.Request.GetLibraryItem(
            id: "my-item"
        )
        .asURLRequest(from: testURL, using: "my-token", customHeaders: [:])

        let data = RequestData(request: request)

        #expect(data.baseURL == testURL.appendingPathComponent("/api/items/my-item"))
        #expect(data.headers == [
            "Accept": "application/json",
            "Authorization": "Bearer my-token",
        ])
        #expect(data.queryItems == [
            "expanded": "1",
            "include": "authors,progress",
        ])
    }

    @Test func response() throws {
        let response = try loadResponse(
            "library_item",
            for: Audiobookshelf.Request.GetLibraryItem.self
        )

        #expect(response.id == "bc0719db-2124-4ba2-9860-1b729cbfcc6e")
        #expect(response.ino == "147827")
        #expect(response.oldLibraryItemId == nil)
        #expect(response.libraryId == "71288985-7f00-4a29-b671-836edde7d3a4")
        #expect(response.folderId == "107b1c26-1f79-4118-acc5-531cc41a9f80")
        #expect(response.path == "/Volumes/media/audiobooks_screenshots/JRR Tolkien/The Hobbit")
        #expect(response.relPath == "JRR Tolkien/The Hobbit")
        #expect(response.isFile == false)
        #expect(response.mtimeMs == Date(timeIntervalSince1970: 1_596_375_037_000 / 1000))
        #expect(response.ctimeMs == Date(timeIntervalSince1970: 1_596_375_037_000 / 1000))
        #expect(response.birthtimeMs == Date(timeIntervalSince1970: 1_596_368_362_000 / 1000))
        #expect(response.addedAt == Date(timeIntervalSince1970: 1_654_499_247_059 / 1000))
        #expect(response.updatedAt == Date(timeIntervalSince1970: 1_713_354_157_355 / 1000))
        #expect(response.lastScan == Date(timeIntervalSince1970: 1_713_354_157_355 / 1000))
        #expect(response.scanVersion == "2.8.1")
        #expect(response.isMissing == false)
        #expect(response.isInvalid == false)
        #expect(response.mediaType == .book)
        #expect(response.media.id == "dbb1da04-8049-4fba-b9b6-bca66e5c9d6a")
        #expect(response.media.libraryItemId == "bc0719db-2124-4ba2-9860-1b729cbfcc6e")
        #expect(response.media.metadata.title == "The Hobbit")
        #expect(response.media.metadata.titleIgnorePrefix == "Hobbit, The")
        #expect(response.media.metadata.subtitle == nil)

        let author = response.media.metadata.authors.first!
        #expect(author.id == "55550aac-c2f4-4649-a517-e03dce886076")
        #expect(author.name == "JRR Tolkien")

        #expect(response.media.metadata.narrators == ["Rob Inglis"])
        #expect(response.media.metadata.series == [])
        #expect(response.media.metadata.genres == ["Fantasy"])
        #expect(response.media.metadata.publishedYear == "1937")
        #expect(response.media.metadata.publishedDate == nil)
        #expect(response.media.metadata.publisher == nil)
        #expect(response.media.metadata.description == nil)
        #expect(response.media.metadata.isbn == nil)
        #expect(response.media.metadata.asin == nil)
        #expect(response.media.metadata.language == nil)
        #expect(response.media.metadata.explicit == false)
        #expect(response.media.metadata.authorName == "JRR Tolkien")
        #expect(response.media.metadata.authorNameLF == "Tolkien, JRR")
        #expect(response.media.metadata.narratorName == "Rob Inglis")
        #expect(response.media.metadata.seriesName == "")
        #expect(response.media.metadata.abridged == false)
        #expect(response.media.tags == [])
        #expect(response.media.audioFiles.count == 1)

        let audioFile = response.media.audioFiles.first!
        #expect(audioFile.index == 1)
        #expect(audioFile.ino == "147831")
        #expect(audioFile.metadata.birthtimeMs == Date(timeIntervalSince1970: 1_596_369_649_000 / 1000))
        #expect(audioFile.addedAt == Date(timeIntervalSince1970: 1_654_499_251_112 / 1000))
        #expect(audioFile.updatedAt == Date(timeIntervalSince1970: 1_654_499_251_112 / 1000))
        #expect(audioFile.trackNumFromMeta == 1)
        #expect(audioFile.discNumFromMeta == nil)
        #expect(audioFile.trackNumFromFilename == nil)
        #expect(audioFile.discNumFromFilename == nil)
        #expect(audioFile.manuallyVerified == false)
        #expect(audioFile.exclude == false)
        #expect(audioFile.error == nil)
        #expect(audioFile.format == "QuickTime / MOV")
        #expect(audioFile.duration == 39720.024)
        #expect(audioFile.bitRate == 2090)
        #expect(audioFile.language == "und")
        #expect(audioFile.codec == "aac")
        #expect(audioFile.timeBase == "1/44100")
        #expect(audioFile.channels == 2)
        #expect(audioFile.channelLayout == "stereo")
        #expect(audioFile.embeddedCoverArt == "png")
        #expect(audioFile.metaTags.tagAlbum == "The Hobbit")
        #expect(audioFile.metaTags.tagArtist == "J. R. R. Tolkien")
        #expect(audioFile.metaTags.tagGenre == "Fantasy")
        #expect(audioFile.metaTags.tagTitle == "The Hobbit")
        #expect(audioFile.metaTags.tagTrack == "1")
        #expect(audioFile.metaTags.tagAlbumArtist == "J. R. R. Tolkien")
        #expect(audioFile.metaTags.tagDate == "1937")
        #expect(audioFile.metaTags.tagComposer == "Rob Inglis")
        #expect(audioFile.metaTags.tagComment == "Bilbo Baggins is a hobbit who enjoys a comfortable, unambitious life, rarely travelling further than the pantry of his hobbit-hole in Bag End. But his contentment is disturbed when the wizard, Gandalf, and a company of 13 dwarves arrive on his doorstep one day to whisk him away on an unexpected journey ‘there and back again’. They have a plot to raid the treasure hoard of Smaug the Magnificent, a large and very dangerous dragon....  The prelude to The Lord of the Rings, The Hobbit has sold many millions of copies since its publication in 1937, establishing itself as one of the most beloved and influential books of the 20th century.")
        #expect(audioFile.metaTags.tagEncoder == "Lavf58.45.100")
        #expect(audioFile.mimeType == "audio/mp4")

        #expect(response.media.chapters.count == 19)
        let firstChapter = response.media.chapters.first!
        #expect(firstChapter.id == 0)
        #expect(firstChapter.start == 0)
        #expect(firstChapter.end == 3678)
        #expect(firstChapter.title == "An Unexpected Party")
        #expect(response.media.duration == 39720.024)
        #expect(response.media.size == 18_226_998)
        #expect(response.media.tracks.count == 1)

        let track = response.media.tracks.first!
        #expect(track.index == 1)
        #expect(track.startOffset == 0)
        #expect(track.duration == 39720.024)
        #expect(track.title == "The Hobbit.m4a")
        #expect(track.contentUrl == "/api/items/bc0719db-2124-4ba2-9860-1b729cbfcc6e/file/147831")
        #expect(track.mimeType == "audio/mp4")
        #expect(track.codec == "aac")
        #expect(track.metadata.filename == "The Hobbit.m4a")
        #expect(track.metadata.ext == ".m4a")
        #expect(track.metadata.path == "/Volumes/media/audiobooks_screenshots/JRR Tolkien/The Hobbit/The Hobbit.m4a")
        #expect(track.metadata.relPath == "The Hobbit.m4a")
        #expect(track.metadata.size == 18_226_998)
        #expect(track.metadata.mtimeMs == Date(timeIntervalSince1970: 1_602_044_390_000 / 1000))
        #expect(track.metadata.ctimeMs == Date(timeIntervalSince1970: 1_602_044_390_000 / 1000))
        #expect(track.metadata.birthtimeMs == Date(timeIntervalSince1970: 1_596_369_649_000 / 1000))
        #expect(response.media.ebookFile == nil)

        #expect(response.libraryFiles.count == 1)
        let libraryFile = response.libraryFiles.first!
        #expect(libraryFile.ino == "147831")
        #expect(libraryFile.metadata.filename == "The Hobbit.m4a")
        #expect(libraryFile.metadata.ext == ".m4a")
        #expect(libraryFile.metadata.path == "/Volumes/media/audiobooks_screenshots/JRR Tolkien/The Hobbit/The Hobbit.m4a")
        #expect(libraryFile.metadata.relPath == "The Hobbit.m4a")
        #expect(libraryFile.metadata.size == 18_226_998)
        #expect(libraryFile.metadata.mtimeMs == Date(timeIntervalSince1970: 1_602_044_390_000 / 1000))
        #expect(libraryFile.metadata.ctimeMs == Date(timeIntervalSince1970: 1_602_044_390_000 / 1000))
        #expect(libraryFile.metadata.birthtimeMs == Date(timeIntervalSince1970: 1_596_369_649_000 / 1000))
        #expect(libraryFile.isSupplementary == nil)
        #expect(libraryFile.addedAt == Date(timeIntervalSince1970: 1_654_499_247_031 / 1000))
        #expect(libraryFile.updatedAt == Date(timeIntervalSince1970: 1_654_499_247_031 / 1000))
        #expect(libraryFile.fileType == "audio")
        #expect(response.size == 18_226_998)
    }

    @Test func response_withEbookFile() throws {
        let response = try loadResponse(
            "library_item_with_ebook",
            for: Audiobookshelf.Request.GetLibraryItem.self
        )

        let ebookFile = try #require(response.media.ebookFile)
        #expect(ebookFile.ino == "114036")
        #expect(ebookFile.metadata.filename == "01 - Harry Potter and the Philosopher's Stone, Book 1.epub")
        #expect(ebookFile.metadata.ext == ".epub")
        #expect(ebookFile.metadata.path == "/audiobooks/J.K. Rowling/Harry Potter/1 - Harry Potter and the Philosopher's Stone/01 - Harry Potter and the Philosopher's Stone, Book 1.epub")
        #expect(ebookFile.metadata.relPath == "01 - Harry Potter and the Philosopher's Stone, Book 1.epub")
        #expect(ebookFile.metadata.size == 266_017)
        #expect(ebookFile.metadata.mtimeMs == Date(timeIntervalSince1970: 1_650_460_083_579 / 1000))
        #expect(ebookFile.metadata.ctimeMs == Date(timeIntervalSince1970: 1_771_163_764_877 / 1000))
        #expect(ebookFile.metadata.birthtimeMs == Date(timeIntervalSince1970: 1_771_163_764_877 / 1000))
        #expect(ebookFile.addedAt == Date(timeIntervalSince1970: 1_771_163_775_220 / 1000))
        #expect(ebookFile.updatedAt == Date(timeIntervalSince1970: 1_771_163_775_220 / 1000))
        #expect(ebookFile.ebookFormat == "epub")

        let audioLibraryFile = try #require(response.libraryFiles.first(where: { $0.fileType == "audio" }))
        #expect(audioLibraryFile.ino == "102873")
        #expect(audioLibraryFile.isSupplementary == nil)

        let ebookLibraryFile = try #require(response.libraryFiles.first(where: { $0.fileType == "ebook" }))
        #expect(ebookLibraryFile.ino == "114036")
        #expect(ebookLibraryFile.metadata.ext == ".epub")
        #expect(ebookLibraryFile.isSupplementary == false)
    }
}
