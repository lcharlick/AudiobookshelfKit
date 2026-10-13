
//
//  LibraryItem.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 14/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public struct LibraryItem: Codable, Hashable, Identifiable, Sendable {
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
    /// Whether the library item was scanned and no longer exists.
    @Lenient public var isMissing: Bool?
    /// Whether the library item was scanned and no longer has media files.
    @Lenient public var isInvalid: Bool?
    /// What kind of media the library item contains.
    @Lenient public var mediaType: MediaType?
    /// The media of the library item.
    @DefaultEmpty public var media: Book
    /// The number of files the library item contains.
    @Lenient public var numFiles: Int?
    /// The size of the library item in bytes.
    @Lenient public var size: Int64?
}

public extension LibraryItem {
    struct Book: Codable, Hashable, Identifiable, Sendable {
        /// The ID of the book.
        @Lenient public var id: String?
        /// The book's metadata.
        @DefaultEmpty public var metadata: Metadata
        /// The absolute path on the server of the cover file. Will be null if there is no cover.
        @Lenient public var coverPath: String?
        /// The book's tags.
        @LossyArray public var tags: [String]
        /// The number of tracks the book contains.
        @Lenient public var numTracks: Int?
        /// The number of audio files the book contains.
        @Lenient public var numAudioFiles: Int?
        /// The number of chapters the book contains.
        @Lenient public var numChapters: Int?
        /// The duration of the book in seconds.
        @Lenient public var duration: TimeInterval?
        /// The size of the book in bytes.
        @Lenient public var size: Int64?
    }
}

public extension LibraryItem.Book {
    struct Metadata: Codable, Hashable, Sendable {
        /// The title of the book.
        @Lenient public var title: String?
        /// The sort title of the book.
        @Lenient public var titleIgnorePrefix: String?
        /// The subtitle of the book.
        @Lenient public var subtitle: String?
        /// The authors of the book.
        @Lenient public var authorName: String?
        /// The author's last name, first name.
        @Lenient public var authorNameLF: String?
        /// The narrators of the audiobook.
        @Lenient public var narratorName: String?
        /// The series the book belongs to.
        @Lenient public var seriesName: String?
        /// The genres of the book.
        @LossyArray public var genres: [String]
        /// The year the book was published.
        @Lenient public var publishedYear: String?
        /// The date the book was published.
        @Lenient public var publishedDate: Date?
        /// The publisher of the book.
        @Lenient public var publisher: String?
        /// A description for the book.
        @Lenient public var description: String?
        /// The ISBN of the book.
        @Lenient public var isbn: String?
        /// The ASIN of the book.
        @Lenient public var asin: String?
        /// The language of the book.
        @Lenient public var language: String?
        /// Whether the book has been marked as explicit.
        @Lenient public var explicit: Bool?
        /// Whether the book is abridged.
        @Lenient public var abridged: Bool?
        /// The series the book belongs to, if any.
        /// Only available when filtering by series.
        @Lenient public var series: SeriesSequence?
    }
}
