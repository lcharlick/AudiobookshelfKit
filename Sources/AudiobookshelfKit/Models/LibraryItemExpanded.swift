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
    public let ino: String
    ///
    public let oldLibraryItemId: String?
    /// The ID of the library the item belongs to.
    public let libraryId: String
    /// The ID of the folder the library item is in.
    public let folderId: String?
    /// The path of the library item on the server.
    public let path: String
    /// The path, relative to the library folder, of the library item.
    public let relPath: String
    /// Whether the library item is a single file in the root of the library folder.
    public let isFile: Bool
    /// The time (in ms since POSIX epoch) when the library item was last modified on disk.
    public let mtimeMs: Date?
    /// The time (in ms since POSIX epoch) when the library item status was changed on disk.
    public let ctimeMs: Date?
    /// The time (in ms since POSIX epoch) when the library item was created on disk. Will be 0 if unknown.
    public let birthtimeMs: Date
    /// The time (in ms since POSIX epoch) when the library item was added to the library.
    public let addedAt: Date
    /// The time (in ms since POSIX epoch) when the library item was last updated.
    public let updatedAt: Date
    /// The time (in ms since POSIX epoch) when the library item was last scanned. Will be null if the server has not yet scanned the library item.
    public let lastScan: Date?
    /// The version of the scanner when last scanned. Will be nil if it has not been scanned.
    public let scanVersion: String?
    /// Whether the library item was scanned and no longer exists.
    public let isMissing: Bool
    /// Whether the library item was scanned and no longer has media files.
    public let isInvalid: Bool
    /// What kind of media the library item contains.
    public let mediaType: MediaType
    /// The media of the library item.
    public let media: Book
    /// The files of the library item.
    public let libraryFiles: [LibraryFile]
    /// The size of the library item in bytes.
    public let size: Int64?
}

public extension LibraryItemExpanded {
    struct Book: Codable, Hashable, Identifiable, Sendable {
        public let id: String
        public let libraryItemId: String
        public let metadata: MediaMetadata
        public let coverPath: String?
        public let tags: [String]
        public let audioFiles: [AudioFile]
        public let chapters: [Chapter]
        public let duration: Double
        public let size: Int
        public let tracks: [Track]
        /// The ebook file for this item, if present.
        public let ebookFile: EbookFile?
    }
}

public extension LibraryItemExpanded.Book {
    struct MediaMetadata: Codable, Hashable, Sendable {
        public let title: String
        public let titleIgnorePrefix: String?
        public let subtitle: String?
        public let authors: [AuthorMinified]
        public let narrators: [String]
        public let series: [SeriesSequence]
        public let genres: [String]?
        public let publishedYear: String?
        public let publishedDate: Date?
        public let publisher: String?
        public let description: String?
        public let isbn: String?
        public let asin: String?
        public let language: String?
        public let explicit: Bool?
        public let authorName: String?
        public let authorNameLF: String?
        public let narratorName: String?
        public let seriesName: String?
        public let abridged: Bool?

        enum CodingKeys: String, CodingKey {
            case title
            case titleIgnorePrefix
            case subtitle
            case authors
            case narrators
            case series
            case genres
            case publishedYear
            case publishedDate
            case publisher
            case description
            case isbn
            case asin
            case language
            case explicit
            case authorName
            case authorNameLF
            case narratorName
            case seriesName
            case abridged
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            title = try container.decode(String.self, forKey: .title)
            titleIgnorePrefix = try container.decodeIfPresent(String.self, forKey: .titleIgnorePrefix)
            subtitle = try container.decodeIfPresent(String.self, forKey: .subtitle)
            authors = try container.decode([AuthorMinified].self, forKey: .authors)
            narrators = try container.decode([String].self, forKey: .narrators)
            series = try container.decode([SeriesSequence].self, forKey: .series)
            genres = try container.decodeIfPresent([String].self, forKey: .genres)
            publishedYear = try container.decodeIfPresent(String.self, forKey: .publishedYear)
            publishedDate = try container.decodeAudiobookshelfDateIfPresent(forKey: .publishedDate)
            publisher = try container.decodeIfPresent(String.self, forKey: .publisher)
            description = try container.decodeIfPresent(String.self, forKey: .description)
            isbn = try container.decodeIfPresent(String.self, forKey: .isbn)
            asin = try container.decodeIfPresent(String.self, forKey: .asin)
            language = try container.decodeIfPresent(String.self, forKey: .language)
            explicit = try container.decodeIfPresent(Bool.self, forKey: .explicit)
            authorName = try container.decodeIfPresent(String.self, forKey: .authorName)
            authorNameLF = try container.decodeIfPresent(String.self, forKey: .authorNameLF)
            narratorName = try container.decodeIfPresent(String.self, forKey: .narratorName)
            seriesName = try container.decodeIfPresent(String.self, forKey: .seriesName)
            abridged = try container.decodeIfPresent(Bool.self, forKey: .abridged)
        }
    }
}
