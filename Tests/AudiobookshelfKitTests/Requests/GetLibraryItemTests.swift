//
//  GetLibraryItemTests.swift
//  AudiobookshelfKitTests
//
//  Created by Lachlan Charlick on 14/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import AudiobookshelfKit
import XCTest

class GetLibraryItemTests: BaseTestCase {
    func testRequest() throws {
        let request = try Audiobookshelf.Request.GetLibraryItem(
            id: "my-item"
        )
        .asURLRequest(from: testURL, using: "my-token")

        let data = RequestData(request: request)

        XCTAssertEqual(data.baseURL, testURL.appendingPathComponent("/api/items/my-item"))
        XCTAssertEqual(data.headers, [
            "Accept": "application/json",
            "Authorization": "Bearer my-token",
        ])
        XCTAssertEqual(data.queryItems, [
            "expanded": "1",
            "include": "authors,progress",
        ])
    }

    func testResponse() throws {
        let response = try loadResponse(
            "library_item",
            for: Audiobookshelf.Request.GetLibraryItem.self
        )

        XCTAssertEqual(response.id, "bc0719db-2124-4ba2-9860-1b729cbfcc6e")
        XCTAssertEqual(response.ino, "147827")
        XCTAssertEqual(response.oldLibraryItemId, nil)
        XCTAssertEqual(response.libraryId, "71288985-7f00-4a29-b671-836edde7d3a4")
        XCTAssertEqual(response.folderId, "107b1c26-1f79-4118-acc5-531cc41a9f80")
        XCTAssertEqual(response.path, "/Volumes/media/audiobooks_screenshots/JRR Tolkien/The Hobbit")
        XCTAssertEqual(response.relPath, "JRR Tolkien/The Hobbit")
        XCTAssertEqual(response.isFile, false)
        XCTAssertEqual(response.mtimeMs, Date(timeIntervalSince1970: 1_596_375_037_000 / 1000))
        XCTAssertEqual(response.ctimeMs, Date(timeIntervalSince1970: 1_596_375_037_000 / 1000))
        XCTAssertEqual(response.birthtimeMs, Date(timeIntervalSince1970: 1_596_368_362_000 / 1000))
        XCTAssertEqual(response.addedAt, Date(timeIntervalSince1970: 1_654_499_247_059 / 1000))
        XCTAssertEqual(response.updatedAt, Date(timeIntervalSince1970: 1_713_354_157_355 / 1000))
        XCTAssertEqual(response.lastScan, Date(timeIntervalSince1970: 1_713_354_157_355 / 1000))
        XCTAssertEqual(response.scanVersion, "2.8.1")
        XCTAssertEqual(response.isMissing, false)
        XCTAssertEqual(response.isInvalid, false)
        XCTAssertEqual(response.mediaType, .book)
        XCTAssertEqual(response.media.id, "dbb1da04-8049-4fba-b9b6-bca66e5c9d6a")
        XCTAssertEqual(response.media.libraryItemId, "bc0719db-2124-4ba2-9860-1b729cbfcc6e")
        XCTAssertEqual(response.media.metadata.title, "The Hobbit")
        XCTAssertEqual(response.media.metadata.titleIgnorePrefix, "Hobbit, The")
        XCTAssertEqual(response.media.metadata.subtitle, nil)

        let author = response.media.metadata.authors.first!
        XCTAssertEqual(author.id, "55550aac-c2f4-4649-a517-e03dce886076")
        XCTAssertEqual(author.name, "JRR Tolkien")

        XCTAssertEqual(response.media.metadata.narrators, ["Rob Inglis"])
        XCTAssertEqual(response.media.metadata.series, [])
        XCTAssertEqual(response.media.metadata.genres, ["Fantasy"])
        XCTAssertEqual(response.media.metadata.publishedYear, "1937")
        XCTAssertEqual(response.media.metadata.publishedDate, nil)
        XCTAssertEqual(response.media.metadata.publisher, nil)
        XCTAssertEqual(response.media.metadata.description, nil)
        XCTAssertEqual(response.media.metadata.isbn, nil)
        XCTAssertEqual(response.media.metadata.asin, nil)
        XCTAssertEqual(response.media.metadata.language, nil)
        XCTAssertEqual(response.media.metadata.explicit, false)
        XCTAssertEqual(response.media.metadata.authorName, "JRR Tolkien")
        XCTAssertEqual(response.media.metadata.authorNameLF, "Tolkien, JRR")
        XCTAssertEqual(response.media.metadata.narratorName, "Rob Inglis")
        XCTAssertEqual(response.media.metadata.seriesName, "")
        XCTAssertEqual(response.media.metadata.abridged, false)
        XCTAssertEqual(response.media.coverPath, "/Users/lcharlick/git/audiobookshelf/metadata/items/li_3xi3eu3m5ey3gcj45x/cover.png")
        XCTAssertEqual(response.media.tags, [])
        XCTAssertEqual(response.media.audioFiles.count, 1)

        let audioFile = response.media.audioFiles.first!
        XCTAssertEqual(audioFile.index, 1)
        XCTAssertEqual(audioFile.ino, "147831")
        XCTAssertEqual(audioFile.metadata.birthtimeMs, Date(timeIntervalSince1970: 1_596_369_649_000 / 1000))
        XCTAssertEqual(audioFile.addedAt, Date(timeIntervalSince1970: 1_654_499_251_112 / 1000))
        XCTAssertEqual(audioFile.updatedAt, Date(timeIntervalSince1970: 1_654_499_251_112 / 1000))
        XCTAssertEqual(audioFile.trackNumFromMeta, 1)
        XCTAssertEqual(audioFile.discNumFromMeta, nil)
        XCTAssertEqual(audioFile.trackNumFromFilename, nil)
        XCTAssertEqual(audioFile.discNumFromFilename, nil)
        XCTAssertEqual(audioFile.manuallyVerified, false)
        XCTAssertEqual(audioFile.exclude, false)
        XCTAssertEqual(audioFile.error, nil)
        XCTAssertEqual(audioFile.format, "QuickTime / MOV")
        XCTAssertEqual(audioFile.duration, 39720.024)
        XCTAssertEqual(audioFile.bitRate, 2090)
        XCTAssertEqual(audioFile.language, "und")
        XCTAssertEqual(audioFile.codec, "aac")
        XCTAssertEqual(audioFile.timeBase, "1/44100")
        XCTAssertEqual(audioFile.channels, 2)
        XCTAssertEqual(audioFile.channelLayout, "stereo")
        XCTAssertEqual(audioFile.embeddedCoverArt, "png")
        XCTAssertEqual(audioFile.metaTags.tagAlbum, "The Hobbit")
        XCTAssertEqual(audioFile.metaTags.tagArtist, "J. R. R. Tolkien")
        XCTAssertEqual(audioFile.metaTags.tagGenre, "Fantasy")
        XCTAssertEqual(audioFile.metaTags.tagTitle, "The Hobbit")
        XCTAssertEqual(audioFile.metaTags.tagTrack, "1")
        XCTAssertEqual(audioFile.metaTags.tagAlbumArtist, "J. R. R. Tolkien")
        XCTAssertEqual(audioFile.metaTags.tagDate, "1937")
        XCTAssertEqual(audioFile.metaTags.tagComposer, "Rob Inglis")
        XCTAssertEqual(audioFile.metaTags.tagComment, "Bilbo Baggins is a hobbit who enjoys a comfortable, unambitious life, rarely travelling further than the pantry of his hobbit-hole in Bag End. But his contentment is disturbed when the wizard, Gandalf, and a company of 13 dwarves arrive on his doorstep one day to whisk him away on an unexpected journey ‘there and back again’. They have a plot to raid the treasure hoard of Smaug the Magnificent, a large and very dangerous dragon....  The prelude to The Lord of the Rings, The Hobbit has sold many millions of copies since its publication in 1937, establishing itself as one of the most beloved and influential books of the 20th century.")
        XCTAssertEqual(audioFile.metaTags.tagEncoder, "Lavf58.45.100")
        XCTAssertEqual(audioFile.mimeType, "audio/mp4")

        XCTAssertEqual(response.media.chapters.count, 19)
        let firstChapter = response.media.chapters.first!
        XCTAssertEqual(firstChapter.id, 0)
        XCTAssertEqual(firstChapter.start, 0)
        XCTAssertEqual(firstChapter.end, 3678)
        XCTAssertEqual(firstChapter.title, "An Unexpected Party")
        XCTAssertEqual(response.media.duration, 39720.024)
        XCTAssertEqual(response.media.size, 18_226_998)
        XCTAssertEqual(response.media.tracks.count, 1)

        let track = response.media.tracks.first!
        XCTAssertEqual(track.index, 1)
        XCTAssertEqual(track.startOffset, 0)
        XCTAssertEqual(track.duration, 39720.024)
        XCTAssertEqual(track.title, "The Hobbit.m4a")
        XCTAssertEqual(track.contentUrl, "/api/items/bc0719db-2124-4ba2-9860-1b729cbfcc6e/file/147831")
        XCTAssertEqual(track.mimeType, "audio/mp4")
        XCTAssertEqual(track.codec, "aac")
        XCTAssertEqual(track.metadata.filename, "The Hobbit.m4a")
        XCTAssertEqual(track.metadata.ext, ".m4a")
        XCTAssertEqual(track.metadata.path, "/Volumes/media/audiobooks_screenshots/JRR Tolkien/The Hobbit/The Hobbit.m4a")
        XCTAssertEqual(track.metadata.relPath, "The Hobbit.m4a")
        XCTAssertEqual(track.metadata.size, 18_226_998)
        XCTAssertEqual(track.metadata.mtimeMs, Date(timeIntervalSince1970: 1_602_044_390_000 / 1000))
        XCTAssertEqual(track.metadata.ctimeMs, Date(timeIntervalSince1970: 1_602_044_390_000 / 1000))
        XCTAssertEqual(track.metadata.birthtimeMs, Date(timeIntervalSince1970: 1_596_369_649_000 / 1000))
        // XCTAssertEqual(response.media.ebookFile, nil)

        XCTAssertEqual(response.libraryFiles.count, 1)
        let libraryFile = response.libraryFiles.first!
        XCTAssertEqual(libraryFile.ino, "147831")
        XCTAssertEqual(libraryFile.metadata.filename, "The Hobbit.m4a")
        XCTAssertEqual(libraryFile.metadata.ext, ".m4a")
        XCTAssertEqual(libraryFile.metadata.path, "/Volumes/media/audiobooks_screenshots/JRR Tolkien/The Hobbit/The Hobbit.m4a")
        XCTAssertEqual(libraryFile.metadata.relPath, "The Hobbit.m4a")
        XCTAssertEqual(libraryFile.metadata.size, 18_226_998)
        XCTAssertEqual(libraryFile.metadata.mtimeMs, Date(timeIntervalSince1970: 1_602_044_390_000 / 1000))
        XCTAssertEqual(libraryFile.metadata.ctimeMs, Date(timeIntervalSince1970: 1_602_044_390_000 / 1000))
        XCTAssertEqual(libraryFile.metadata.birthtimeMs, Date(timeIntervalSince1970: 1_596_369_649_000 / 1000))
        XCTAssertEqual(libraryFile.isSupplementary, nil)
        XCTAssertEqual(libraryFile.addedAt, Date(timeIntervalSince1970: 1_654_499_247_031 / 1000))
        XCTAssertEqual(libraryFile.updatedAt, Date(timeIntervalSince1970: 1_654_499_247_031 / 1000))
        XCTAssertEqual(libraryFile.fileType, "audio")
        XCTAssertEqual(response.size, 18_226_998)
    }
}
