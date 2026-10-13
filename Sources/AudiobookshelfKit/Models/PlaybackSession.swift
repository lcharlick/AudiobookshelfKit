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
    @Lenient public var userId: String?
    /// The ID of the library that contains the library item.
    @Lenient public var libraryId: String?
    /// The ID of the library item. Will be null if the server cannot associate the session with an item.
    @Lenient public var libraryItemId: String?
    /// The ID of the podcast episode. Will be null if this playback session was started without an episode ID.
    @Lenient public var episodeId: String?
    /// The media type of the library item. Will be book or podcast.
    @Lenient public var mediaType: String?
    /// The title of the playing item to show to the user.
    @Lenient public var displayTitle: String?
    /// The author of the playing item to show to the user.
    @Lenient public var displayAuthor: String?
    /// The cover path of the library item's media.
    @Lenient public var coverPath: String?
    /// The total duration (in seconds) of the playing item.
    @Lenient public var duration: TimeInterval?
    /// What play method the playback session is using. See below for values.
    @Lenient public var playMethod: PlayMethod?
    /// The given media player when the playback session was requested.
    @Lenient public var mediaPlayer: String?
    /// The given device info when the playback session was requested.
    @DefaultEmpty public var deviceInfo: DeviceInfo
    /// The server version the playback session was started with.
    @Lenient public var serverVersion: String?
    /// The day (in the format YYYY-MM-DD) the playback session was started.
    @Lenient public var date: String?
    /// The day of the week the playback session was started.
    @Lenient public var dayOfWeek: String?
    /// The amount of time (in seconds) the user has spent listening using this playback session.
    @Lenient public var timeListening: TimeInterval?
    /// The time (in seconds) where the playback session started.
    @Lenient public var startTime: TimeInterval?
    /// The current time (in seconds) of the playback position.
    @Lenient public var currentTime: TimeInterval?
    /// The time (in ms since POSIX epoch) when the playback session was started.
    @Lenient public var startedAt: Date?
    /// The time (in ms since POSIX epoch) when the playback session was last updated.
    @Lenient public var updatedAt: Date?
}
