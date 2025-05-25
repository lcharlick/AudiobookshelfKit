
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
    public let ino: String
    ///
    public let oldLibraryItemId: String?
    /// The ID of the library the item belongs to.
    public let libraryId: String
    /// The ID of the folder the library item is in.
    public let folderId: String
    /// The path of the library item on the server.
    public let path: String
    /// The path, relative to the library folder, of the library item.
    public let relPath: String
    /// Whether the library item is a single file in the root of the library folder.
    public let isFile: Bool
    /// The time (in ms since POSIX epoch) when the library item was last modified on disk.
    public let mtimeMs: Date
    /// The time (in ms since POSIX epoch) when the library item status was changed on disk.
    public let ctimeMs: Date
    /// The time (in ms since POSIX epoch) when the library item was created on disk. Will be 0 if unknown.
    public let birthtimeMs: Date
    /// The time (in ms since POSIX epoch) when the library item was added to the library.
    public let addedAt: Date
    /// The time (in ms since POSIX epoch) when the library item was last updated.
    public let updatedAt: Date
    /// Whether the library item was scanned and no longer exists.
    public let isMissing: Bool
    /// Whether the library item was scanned and no longer has media files.
    public let isInvalid: Bool
    /// What kind of media the library item contains.
    public let mediaType: MediaType
    /// The media of the library item.
    public let media: Book
    /// The number of files the library item contains.
    public let numFiles: Int?
    /// The size of the library item in bytes.
    public let size: Int64
}

public extension LibraryItem {
    struct Book: Codable, Hashable, Identifiable, Sendable {
        /// The ID of the book.
        public let id: String
        /// The book's metadata.
        public let metadata: Metadata
        /// The absolute path on the server of the cover file. Will be null if there is no cover.
        public let coverPath: String?
        /// The book's tags.
        public let tags: [String]
        /// The number of tracks the book contains.
        public let numTracks: Int?
        /// The number of audio files the book contains.
        public let numAudioFiles: Int?
        /// The number of chapters the book contains.
        public let numChapters: Int?
        /// The duration of the book in seconds.
        public let duration: TimeInterval
        /// The size of the book in bytes.
        public let size: Int64
    }
}

public extension LibraryItem.Book {
    struct Metadata: Codable, Hashable, Sendable {
        /// The title of the book.
        public let title: String
        /// The sort title of the book.
        public let titleIgnorePrefix: String?
        /// The subtitle of the book.
        public let subtitle: String?
        /// The authors of the book.
        public let authorName: String
        /// The author's last name, first name.
        public let authorNameLF: String
        /// The narrators of the audiobook.
        public let narratorName: String
        /// The series the book belongs to.
        public let seriesName: String?
        /// The genres of the book.
        public let genres: [String]?
        /// The year the book was published.
        public let publishedYear: String?
        /// The date the book was published.
        public let publishedDate: Date?
        /// The publisher of the book.
        public let publisher: String?
        /// A description for the book.
        public let description: String?
        /// The ISBN of the book.
        public let isbn: String?
        /// The ASIN of the book.
        public let asin: String?
        /// The language of the book.
        public let language: String?
        /// Whether the book has been marked as explicit.
        public let explicit: Bool
        /// Whether the book is abridged.
        public let abridged: Bool
    }
}
