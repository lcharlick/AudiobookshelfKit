//
//  PlaybackSession.swift
//  AudiobookshelfKit
//
//  Created by Lachlan Charlick on 25/4/25.
//  Copyright © 2025 Lachlan Charlick. All rights reserved.
//

import Foundation

public struct PlaybackSession: Codable, Hashable, Identifiable, Sendable {
    /// The ID of the playback session.
    public let id: String
    /// The ID of the user the playback session is for.
    public let userId: String
    /// The ID of the library that contains the library item.
    public let libraryId: String
    /// The ID of the library item.
    public let libraryItemId: String
    /// The ID of the podcast episode. Will be null if this playback session was started without an episode ID.
    public let episodeId: String?
    /// The media type of the library item. Will be book or podcast.
    public let mediaType: String
    /// The metadata of the library item's media.
    public let mediaMetadata: LibraryItemExpanded.Book.MediaMetadata?
    /// The chapters of the library item.
    public let chapters: [Chapter]?
    /// The title of the playing item to show to the user.
    public let displayTitle: String?
    /// The author of the playing item to show to the user.
    public let displayAuthor: String?
    /// The cover path of the library item's media.
    public let coverPath: String?
    /// The total duration (in seconds) of the playing item.
    public let duration: TimeInterval?
    /// What play method the playback session is using. See below for values.
    public let playMethod: PlayMethod
    /// The given media player when the playback session was requested.
    public let mediaPlayer: String?
    /// The given device info when the playback session was requested.
    public let deviceInfo: DeviceInfo
    /// The server version the playback session was started with.
    public let serverVersion: String?
    /// The day (in the format YYYY-MM-DD) the playback session was started.
    public let date: String?
    /// The day of the week the playback session was started.
    public let dayOfWeek: String?
    /// The amount of time (in seconds) the user has spent listening using this playback session.
    public let timeListening: TimeInterval?
    /// The time (in seconds) where the playback session started.
    public let startTime: TimeInterval?
    /// The current time (in seconds) of the playback position.
    public let currentTime: TimeInterval?
    /// The time (in ms since POSIX epoch) when the playback session was started.
    public let startedAt: Date?
    /// The time (in ms since POSIX epoch) when the playback session was last updated.
    public let updatedAt: Date?
}
