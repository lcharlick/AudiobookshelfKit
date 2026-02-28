//
//  AudioFile.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 18/4/24.
//  Copyright © 2024 Lachlan Charlick. All rights reserved.
//

import Foundation

public struct AudioFile: Codable, Hashable, Sendable {
    /// The index of the audio file.
    public let index: Int
    /// The inode of the audio file.
    public let ino: String
    /// The audio file's metadata.
    public let metadata: LibraryFile.Metadata
    /// The time when the audio file was added to the library.
    public let addedAt: Date
    /// The time when the audio file was last updated.
    public let updatedAt: Date
    /// The track number of the audio file as pulled from the file's metadata. Will be null if unknown.
    public let trackNumFromMeta: Int?
    /// The disc number of the audio file as pulled from the file's metadata. Will be null if unknown.
    public let discNumFromMeta: Int?
    /// The track number of the audio file as determined from the file's name. Will be null if unknown.
    public let trackNumFromFilename: Int?
    /// The disc number of the audio file as determined from the file's name. Will be null if unknown.
    public let discNumFromFilename: Int?
    /// Whether the audio file has been manually verified by a user.
    public let manuallyVerified: Bool
    /// Whether the audio file has been marked for exclusion.
    public let exclude: Bool
    /// Any error with the audio file. Will be nil if there is none.
    public let error: String?
    /// The format of the audio file.
    public let format: String
    /// The total length (in seconds) of the audio file.
    public let duration: TimeInterval?
    /// The bit rate (in bit/s) of the audio file.
    public let bitRate: Int?
    /// The language of the audio file.
    public let language: String?
    /// The codec of the audio file.
    public let codec: String?
    /// The time base of the audio file.
    public let timeBase: String
    /// The number of channels the audio file has.
    public let channels: Int
    /// The layout of the audio file's channels.
    public let channelLayout: String?
    /// If the audio file is part of an audiobook, the chapters the file contains.
    public let chapters: [Chapter]
    /// The type of embedded cover art in the audio file. Will be nil if none exists.
    public let embeddedCoverArt: String?
    /// The audio metadata tags from the audio file.
    public let metaTags: MetaTags
    /// The MIME type of the audio file.
    public let mimeType: String
}

public extension AudioFile {
    struct MetaTags: Codable, Hashable, Sendable {
        public let tagAlbum: String?
        public let tagArtist: String?
        public let tagGenre: String?
        public let tagTitle: String?
        public let tagSeries: String?
        public let tagSeriesPart: String?
        public let tagTrack: String?
        public let tagDisc: String?
        public let tagSubtitle: String?
        public let tagAlbumArtist: String?
        public let tagDate: String?
        public let tagComposer: String?
        public let tagPublisher: String?
        public let tagComment: String?
        public let tagDescription: String?
        public let tagEncoder: String?
        public let tagEncodedBy: String?
        public let tagIsbn: String?
        public let tagLanguage: String?
        public let tagASIN: String?
        public let tagOverdriveMediaMarker: String?
        public let tagOriginalYear: String?
        public let tagReleaseCountry: String?
        public let tagReleaseType: String?
        public let tagReleaseStatus: String?
        public let tagISRC: String?
        public let tagMusicBrainzTrackId: String?
        public let tagMusicBrainzAlbumId: String?
        public let tagMusicBrainzAlbumArtistId: String?
        public let tagMusicBrainzArtistId: String?
    }
}
