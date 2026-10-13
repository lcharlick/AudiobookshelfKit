//
//  LibraryItemExpanded.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 18/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public struct LibraryItemExpanded: Codable, Hashable, Identifiable, Sendable {
    /// The ID of the library item.
    public let id: String
    /// The inode of the library item.
    @Lenient public var ino: String?
    ///
    @Lenient public var oldLibraryItemId: String?
    /// The ID of the library the item belongs to.
    @Lenient public var libraryId: String?
    /// The ID of the folder the library item is in.
    @Lenient public var folderId: String?
    /// The path of the library item on the server.
    @Lenient public var path: String?
    /// The path, relative to the library folder, of the library item.
    @Lenient public var relPath: String?
    /// Whether the library item is a single file in the root of the library folder.
    @Lenient public var isFile: Bool?
    /// The time (in ms since POSIX epoch) when the library item was last modified on disk.
    @Lenient public var mtimeMs: Date?
    /// The time (in ms since POSIX epoch) when the library item status was changed on disk.
    @Lenient public var ctimeMs: Date?
    /// The time (in ms since POSIX epoch) when the library item was created on disk. Will be 0 if unknown.
    @Lenient public var birthtimeMs: Date?
    /// The time (in ms since POSIX epoch) when the library item was added to the library.
    @Lenient public var addedAt: Date?
    /// The time (in ms since POSIX epoch) when the library item was last updated.
    @Lenient public var updatedAt: Date?
    /// The time (in ms since POSIX epoch) when the library item was last scanned. Will be null if the server has not yet scanned the library item.
    @Lenient public var lastScan: Date?
    /// The version of the scanner when last scanned. Will be nil if it has not been scanned.
    @Lenient public var scanVersion: String?
    /// Whether the library item was scanned and no longer exists.
    @Lenient public var isMissing: Bool?
    /// Whether the library item was scanned and no longer has media files.
    @Lenient public var isInvalid: Bool?
    /// What kind of media the library item contains.
    @Lenient public var mediaType: MediaType?
    /// The media of the library item.
    @DefaultEmpty public var media: Book
    /// The files of the library item.
    @LossyArray public var libraryFiles: [LibraryFile]
    /// The size of the library item in bytes.
    @Lenient public var size: Int64?
}

public extension LibraryItemExpanded {
    struct Book: Codable, Hashable, Identifiable, Sendable {
        @Lenient public var id: String?
        @Lenient public var libraryItemId: String?
        @DefaultEmpty public var metadata: MediaMetadata
        @Lenient public var coverPath: String?
        @LossyArray public var tags: [String]
        @LossyArray public var audioFiles: [AudioFile]
        @LossyArray public var chapters: [Chapter]
        @Lenient public var duration: Double?
        @Lenient public var size: Int?
        @LossyArray public var tracks: [Track]
        /// The ebook file for this item, if present.
        @Lenient public var ebookFile: EbookFile?
    }
}

public extension LibraryItemExpanded.Book {
    struct MediaMetadata: Codable, Hashable, Sendable {
        @Lenient public var title: String?
        @Lenient public var titleIgnorePrefix: String?
        @Lenient public var subtitle: String?
        @LossyArray public var authors: [AuthorMinified]
        @LossyArray public var narrators: [String]
        @LossyArray public var series: [SeriesSequence]
        @LossyArray public var genres: [String]
        @Lenient public var publishedYear: String?
        @Lenient public var publishedDate: Date?
        @Lenient public var publisher: String?
        @Lenient public var description: String?
        @Lenient public var isbn: String?
        @Lenient public var asin: String?
        @Lenient public var language: String?
        @Lenient public var explicit: Bool?
        @Lenient public var authorName: String?
        @Lenient public var authorNameLF: String?
        @Lenient public var narratorName: String?
        @Lenient public var seriesName: String?
        @Lenient public var abridged: Bool?
    }
}
