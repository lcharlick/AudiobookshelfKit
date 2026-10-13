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
    @Lenient public var index: Int?
    /// The inode of the audio file.
    @Lenient public var ino: String?
    /// The audio file's metadata.
    @DefaultEmpty public var metadata: LibraryFile.Metadata
    /// The time when the audio file was added to the library.
    @Lenient public var addedAt: Date?
    /// The time when the audio file was last updated.
    @Lenient public var updatedAt: Date?
    /// The track number of the audio file as pulled from the file's metadata. Will be null if unknown.
    @Lenient public var trackNumFromMeta: Int?
    /// The disc number of the audio file as pulled from the file's metadata. Will be null if unknown.
    @Lenient public var discNumFromMeta: Int?
    /// The track number of the audio file as determined from the file's name. Will be null if unknown.
    @Lenient public var trackNumFromFilename: Int?
    /// The disc number of the audio file as determined from the file's name. Will be null if unknown.
    @Lenient public var discNumFromFilename: Int?
    /// Whether the audio file has been manually verified by a user.
    @Lenient public var manuallyVerified: Bool?
    /// Whether the audio file has been marked for exclusion.
    @Lenient public var exclude: Bool?
    /// Any error with the audio file. Will be nil if there is none.
    @Lenient public var error: String?
    /// The format of the audio file.
    @Lenient public var format: String?
    /// The total length (in seconds) of the audio file.
    @Lenient public var duration: TimeInterval?
    /// The bit rate (in bit/s) of the audio file.
    @Lenient public var bitRate: Int?
    /// The language of the audio file.
    @Lenient public var language: String?
    /// The codec of the audio file.
    @Lenient public var codec: String?
    /// The time base of the audio file.
    @Lenient public var timeBase: String?
    /// The number of channels the audio file has.
    @Lenient public var channels: Int?
    /// The layout of the audio file's channels.
    @Lenient public var channelLayout: String?
    /// If the audio file is part of an audiobook, the chapters the file contains.
    @LossyArray public var chapters: [Chapter]
    /// The type of embedded cover art in the audio file. Will be nil if none exists.
    @Lenient public var embeddedCoverArt: String?
    /// The audio metadata tags from the audio file.
    @DefaultEmpty public var metaTags: MetaTags
    /// The MIME type of the audio file.
    @Lenient public var mimeType: String?
}

public extension AudioFile {
    struct MetaTags: Codable, Hashable, Sendable {
        @Lenient public var tagAlbum: String?
        @Lenient public var tagArtist: String?
        @Lenient public var tagGenre: String?
        @Lenient public var tagTitle: String?
        @Lenient public var tagSeries: String?
        @Lenient public var tagSeriesPart: String?
        @Lenient public var tagTrack: String?
        @Lenient public var tagDisc: String?
        @Lenient public var tagSubtitle: String?
        @Lenient public var tagAlbumArtist: String?
        @Lenient public var tagDate: String?
        @Lenient public var tagComposer: String?
        @Lenient public var tagPublisher: String?
        @Lenient public var tagComment: String?
        @Lenient public var tagDescription: String?
        @Lenient public var tagEncoder: String?
        @Lenient public var tagEncodedBy: String?
        @Lenient public var tagIsbn: String?
        @Lenient public var tagLanguage: String?
        @Lenient public var tagASIN: String?
        @Lenient public var tagOverdriveMediaMarker: String?
        @Lenient public var tagOriginalYear: String?
        @Lenient public var tagReleaseCountry: String?
        @Lenient public var tagReleaseType: String?
        @Lenient public var tagReleaseStatus: String?
        @Lenient public var tagISRC: String?
        @Lenient public var tagMusicBrainzTrackId: String?
        @Lenient public var tagMusicBrainzAlbumId: String?
        @Lenient public var tagMusicBrainzAlbumArtistId: String?
        @Lenient public var tagMusicBrainzArtistId: String?
    }
}
